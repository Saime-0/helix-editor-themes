/* Демонстрация синтаксиса C для проверки темы. */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdint.h>
#include <math.h>

#define MAX_RETRY    3
#define HEX_FLAG     0xFF00
#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
#define LOG(fmt, ...) fprintf(stderr, "[%s:%d] " fmt "\n", __FILE__, __LINE__, ##__VA_ARGS__)

/* Константы */
static const double PI = 3.14159265358979;
static const char *GREETING = "привет, мир";
static const int WORKERS = 4;

/* Перечисление */
typedef enum {
    STATUS_PENDING,
    STATUS_RUNNING,
    STATUS_DONE,
    STATUS_FAILED
} Status;

/* Структуры */
typedef struct {
    char key[64];
    char value[256];
} MetaEntry;

typedef struct Task {
    int64_t     id;
    char        name[128];
    Status      status;
    char       *tags[16];
    int         tag_count;
    MetaEntry   meta[8];
    int         meta_count;
    struct Task *next;  /* linked list */
} Task;

typedef struct {
    Task  *head;
    Task  *tail;
    int    count;
    int    workers;
} Scheduler;

/* Указатель на функцию */
typedef bool (*TaskFilter)(const Task *task, void *ctx);

/* Прототипы */
static Task *task_new(int64_t id, const char *name);
static void  task_free(Task *task);
static void  task_add_tag(Task *task, const char *tag);
static bool  task_execute(Task *task);

static Scheduler *scheduler_new(int workers);
static void       scheduler_free(Scheduler *s);
static void       scheduler_submit(Scheduler *s, const char *name);
static int        scheduler_process(Scheduler *s);

/* Реализация */
static Task *task_new(int64_t id, const char *name)
{
    Task *t = calloc(1, sizeof(Task));
    if (!t) {
        LOG("ошибка выделения памяти");
        return NULL;
    }

    t->id = id;
    strncpy(t->name, name, sizeof(t->name) - 1);
    t->status = STATUS_PENDING;
    t->next = NULL;

    return t;
}

static void task_free(Task *task)
{
    if (!task) return;

    for (int i = 0; i < task->tag_count; i++) {
        free(task->tags[i]);
    }
    free(task);
}

static void task_add_tag(Task *task, const char *tag)
{
    if (task->tag_count >= (int)ARRAY_SIZE(task->tags)) {
        LOG("превышен лимит тегов для '%s'", task->name);
        return;
    }
    task->tags[task->tag_count++] = strdup(tag);
}

static bool task_execute(Task *task)
{
    if (!task || !task->name[0]) {
        return false;
    }

    task->status = STATUS_RUNNING;

    /* Имитация работы */
    double result = sin(PI / 4.0) * cos(PI / 4.0);
    (void)result;

    task->status = STATUS_DONE;
    return true;
}

static Scheduler *scheduler_new(int workers)
{
    Scheduler *s = calloc(1, sizeof(Scheduler));
    if (s) {
        s->workers = workers;
    }
    return s;
}

static void scheduler_submit(Scheduler *s, const char *name)
{
    Task *t = task_new(s->count + 1, name);
    if (!t) return;

    if (!s->head) {
        s->head = s->tail = t;
    } else {
        s->tail->next = t;
        s->tail = t;
    }
    s->count++;
}

static int scheduler_process(Scheduler *s)
{
    int completed = 0;

    for (Task *t = s->head; t != NULL; t = t->next) {
        bool success = false;

        for (int retry = 0; retry < MAX_RETRY; retry++) {
            if (task_execute(t)) {
                success = true;
                completed++;
                break;
            }
            LOG("retry %d для '%s'", retry + 1, t->name);
        }

        if (!success) {
            t->status = STATUS_FAILED;
            LOG("не удалось: '%s'", t->name);
        }
    }

    return completed;
}

static void scheduler_free(Scheduler *s)
{
    if (!s) return;

    Task *t = s->head;
    while (t) {
        Task *next = t->next;
        task_free(t);
        t = next;
    }
    free(s);
}

/* Фильтрация через callback */
static int scheduler_filter(Scheduler *s, TaskFilter fn, void *ctx)
{
    int count = 0;
    for (Task *t = s->head; t; t = t->next) {
        if (fn(t, ctx)) {
            printf("  #%ld %s [%d]\n", t->id, t->name, t->status);
            count++;
        }
    }
    return count;
}

static bool filter_done(const Task *t, void *ctx)
{
    (void)ctx;
    return t->status == STATUS_DONE;
}

/* Битовые операции, switch */
static const char *status_name(Status s)
{
    switch (s) {
    case STATUS_PENDING: return "pending";
    case STATUS_RUNNING: return "running";
    case STATUS_DONE:    return "done";
    case STATUS_FAILED:  return "failed";
    default:             return "unknown";
    }
}

int main(int argc, char *argv[])
{
    (void)argc;
    (void)argv;

    Scheduler *s = scheduler_new(WORKERS);
    if (!s) return EXIT_FAILURE;

    scheduler_submit(s, "build");
    scheduler_submit(s, "test");
    scheduler_submit(s, "deploy");

    /* Теги */
    task_add_tag(s->head, "ci");
    task_add_tag(s->head, "docker");

    int done = scheduler_process(s);
    printf("завершено %d из %d\n", done, s->count);

    /* Числа */
    uint32_t mask = HEX_FLAG & 0xF0;
    int oct = 0777;
    long bin = 0b10101010;
    printf("mask=%u oct=%d bin=%ld\n", mask, oct, bin);

    /* Строки */
    char buf[64];
    snprintf(buf, sizeof(buf), "задач: %d, pi: %.4f", s->count, PI);
    printf("%s\n", buf);

    /* Фильтрация */
    printf("завершённые:\n");
    scheduler_filter(s, filter_done, NULL);

    scheduler_free(s);
    return EXIT_SUCCESS;
}
