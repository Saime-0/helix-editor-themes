-- Демонстрация синтаксиса SQL для проверки темы.

CREATE TABLE IF NOT EXISTS tasks (
    id          BIGSERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    status      VARCHAR(20) NOT NULL DEFAULT 'pending',
    priority    INTEGER NOT NULL DEFAULT 0,
    tags        TEXT[] DEFAULT '{}',
    meta        JSONB DEFAULT '{}',
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ,

    CONSTRAINT chk_status CHECK (status IN ('pending', 'running', 'done', 'failed')),
    CONSTRAINT chk_priority CHECK (priority BETWEEN 0 AND 10)
);

CREATE INDEX idx_tasks_status ON tasks (status);
CREATE INDEX idx_tasks_tags ON tasks USING GIN (tags);
CREATE INDEX idx_tasks_meta ON tasks USING GIN (meta);

-- Insert
INSERT INTO tasks (name, status, priority, tags, meta)
VALUES
    ('build', 'done', 5, ARRAY['ci', 'docker'], '{"duration": 120}'),
    ('test', 'running', 3, ARRAY['ci'], '{"attempt": 2}'),
    ('deploy', 'pending', 8, ARRAY['prod'], '{}');

-- Select с подзапросом, JOIN, агрегацией
SELECT
    t.id,
    t.name,
    t.status,
    t.priority,
    COALESCE(t.meta->>'duration', '0')::INTEGER AS duration_sec,
    array_length(t.tags, 1) AS tag_count,
    COUNT(l.id) AS log_entries
FROM tasks t
LEFT JOIN task_logs l ON l.task_id = t.id
WHERE t.status != 'failed'
  AND t.created_at >= NOW() - INTERVAL '7 days'
  AND t.priority > 2
  AND 'ci' = ANY(t.tags)
GROUP BY t.id, t.name, t.status, t.priority, t.meta, t.tags
HAVING COUNT(l.id) > 0
ORDER BY t.priority DESC, t.created_at ASC
LIMIT 50 OFFSET 0;

-- CTE
WITH active_tasks AS (
    SELECT id, name, status, priority
    FROM tasks
    WHERE status IN ('pending', 'running')
),
stats AS (
    SELECT
        status,
        COUNT(*) AS total,
        AVG(priority) AS avg_priority,
        MAX(created_at) AS latest
    FROM tasks
    GROUP BY status
)
SELECT
    a.name,
    s.total,
    ROUND(s.avg_priority, 2) AS avg_prio
FROM active_tasks a
JOIN stats s ON s.status = a.status;

-- Window functions
SELECT
    name,
    status,
    priority,
    ROW_NUMBER() OVER (PARTITION BY status ORDER BY priority DESC) AS rank,
    LAG(name) OVER (ORDER BY created_at) AS prev_task,
    SUM(priority) OVER (ORDER BY created_at ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_sum
FROM tasks;

-- Update с RETURNING
UPDATE tasks
SET
    status = 'done',
    updated_at = NOW(),
    meta = meta || '{"completed": true}'::JSONB
WHERE status = 'running'
  AND created_at < NOW() - INTERVAL '1 hour'
RETURNING id, name;

-- Функция
CREATE OR REPLACE FUNCTION retry_task(
    p_task_id BIGINT,
    p_max_retry INTEGER DEFAULT 3
)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    v_attempt INTEGER;
    v_name VARCHAR;
BEGIN
    SELECT
        (meta->>'attempt')::INTEGER,
        name
    INTO v_attempt, v_name
    FROM tasks
    WHERE id = p_task_id;

    IF v_attempt >= p_max_retry THEN
        RAISE NOTICE 'задача % превысила лимит ретраев', v_name;
        RETURN FALSE;
    END IF;

    UPDATE tasks
    SET
        status = 'pending',
        meta = jsonb_set(meta, '{attempt}', to_jsonb(v_attempt + 1))
    WHERE id = p_task_id;

    RETURN TRUE;
END;
$$;

-- CASE, CAST, EXISTS
SELECT
    name,
    CASE
        WHEN priority >= 8 THEN 'critical'
        WHEN priority >= 5 THEN 'high'
        WHEN priority >= 3 THEN 'medium'
        ELSE 'low'
    END AS severity,
    EXISTS (
        SELECT 1 FROM task_logs WHERE task_id = tasks.id
    ) AS has_logs
FROM tasks;

-- Cleanup
DELETE FROM tasks
WHERE status = 'done'
  AND updated_at < NOW() - INTERVAL '30 days';
