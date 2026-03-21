<?php
// PHP syntax demonstration for theme preview.

declare(strict_types=1);

namespace App\Preview;

use App\Contracts\Runner;
use InvalidArgumentException;
use RuntimeException;

// Constants
const MAX_RETRY = 3;
define('HEX_FLAG', 0xFF);

enum Status: string
{
    case Pending = 'pending';
    case Running = 'running';
    case Done = 'done';
    case Failed = 'failed';
}

#[\Attribute]
class Retry
{
    public function __construct(
        public readonly int $times = 3,
    ) {}
}

readonly class Task
{
    public function __construct(
        public int $id,
        public string $name,
        public Status $status = Status::Pending,
        public array $tags = [],
        private array $meta = [],
    ) {
        if (empty($name)) {
            throw new InvalidArgumentException('task name must not be empty');
        }
    }

    public function __toString(): string
    {
        return "Task#{$this->id} '{$this->name}' [{$this->status->value}]";
    }
}

interface Executable
{
    public function execute(Task $task): bool;
    public function rollback(): void;
}

class Scheduler implements \Countable
{
    /** @var Task[] */
    private array $tasks = [];

    public function __construct(
        private readonly int $workers = 4,
    ) {}

    public function submit(string $name, string ...$tags): Task
    {
        $task = new Task(
            id: count($this->tasks) + 1,
            name: $name,
            tags: $tags,
        );
        $this->tasks[] = $task;
        return $task;
    }

    /**
     * Processes all tasks with retries.
     *
     * @return string[]
     * @throws RuntimeException
     */
    #[Retry(times: 3)]
    public function process(): array
    {
        $results = [];

        foreach ($this->tasks as $i => $task) {
            for ($retry = 0; $retry < MAX_RETRY; $retry++) {
                try {
                    $this->execute($task);
                    $results[] = "{$task}: ok";
                    break;
                } catch (\Throwable $e) {
                    if ($retry === MAX_RETRY - 1) {
                        throw new RuntimeException(
                            "failed to execute: {$e->getMessage()}"
                        );
                    }
                    error_log("retry " . ($retry + 1) . ": {$e->getMessage()}");
                }
            }
        }

        return $results;
    }

    private function execute(Task $task): void
    {
        $task->meta['executed_at'] = time();
    }

    /** @return Task[] */
    public function filter(callable $predicate): array
    {
        return array_filter($this->tasks, $predicate);
    }

    public function count(): int
    {
        return count($this->tasks);
    }
}

// Pattern matching, arrow functions
function describe(Status $status): string
{
    return match ($status) {
        Status::Pending => 'pending',
        Status::Running => 'running',
        Status::Done => 'done',
        Status::Failed => 'failed',
    };
}

// Closures, array functions
$transform = fn(int $x): int => $x * 2 + 1;
$numbers = array_map($transform, range(0, 9));
$evens = array_filter($numbers, fn($n) => $n % 2 === 0);

// Heredoc, Nowdoc
$query = <<<SQL
    SELECT id, name, status
    FROM tasks
    WHERE status = 'done'
    ORDER BY id DESC
SQL;

$raw = <<<'EOT'
    raw string without $interpolation
EOT;

// Null coalescing, spread
$name = $task?->name ?? 'unknown';
$all = [...$numbers, ...$evens];

// Regex
$pattern = '/^task-(\d+)$/i';
$match = preg_match($pattern, 'task-42', $matches);

// Numbers
$pi = 3.14159;
$hex = 0xFF00;
$bin = 0b1010;
$oct = 0o77;
$sci = 1.5e10;
