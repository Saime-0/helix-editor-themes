// TypeScript syntax demonstration for theme preview.

import { EventEmitter } from "events";

// Enum
enum Status {
  Pending = "pending",
  Running = "running",
  Done = "done",
}

// Constants
const MAX_RETRY = 3;
const PI = 3.14159;
const HEX_FLAG = 0xff;
const GREETING = "hello, world";
const TEMPLATE = `tasks: ${MAX_RETRY}, number: ${PI}`;

// Interfaces
interface TaskMeta {
  [key: string]: string | number | boolean;
}

interface Task {
  readonly id: number;
  name: string;
  status: Status;
  tags: string[];
  meta: TaskMeta;
  createdAt: Date;
}

// Type aliases, union, intersection
type TaskId = number | string;
type EventName = "submit" | "complete" | "error";
type Callback<T> = (data: T) => void;
type Nullable<T> = T | null | undefined;

// Class
class Scheduler extends EventEmitter {
  private tasks: Task[] = [];
  private readonly workers: number;

  constructor(workers: number = 4) {
    super();
    this.workers = workers;
  }

  submit(name: string, ...tags: string[]): Task {
    const task: Task = {
      id: this.tasks.length + 1,
      name,
      status: Status.Pending,
      tags,
      meta: {},
      createdAt: new Date(),
    };
    this.tasks.push(task);
    this.emit("submit", task);
    return task;
  }

  async process(): Promise<string[]> {
    const results: string[] = [];

    for (const task of this.tasks) {
      task.status = Status.Running;

      for (let retry = 0; retry < MAX_RETRY; retry++) {
        try {
          await this.execute(task);
          results.push(`${task.name}: ok`);
          break;
        } catch (err) {
          if (retry === MAX_RETRY - 1) {
            this.emit("error", { task, err });
          }
          console.error(`retry ${retry + 1}:`, err);
        }
      }

      task.status = Status.Done;
    }

    return results;
  }

  private async execute(task: Task): Promise<void> {
    if (!task.name) {
      throw new Error("empty task name");
    }
    task.meta["executed_at"] = Date.now();
  }

  // Generics
  filter<T extends Task>(predicate: (task: T) => boolean): T[] {
    return (this.tasks as T[]).filter(predicate);
  }
}

// Destructuring, spread, rest
function formatTask({ id, name, status, ...rest }: Task): string {
  const tagStr = rest.tags.join(", ");
  return `#${id} ${name} [${status}] tags: ${tagStr}`;
}

// Utility types
type ReadonlyTask = Readonly<Task>;
type PartialTask = Partial<Pick<Task, "name" | "tags">>;

// Mapped type
type StatusMap = {
  [K in Status]: Task[];
};

// Conditional type
type IsString<T> = T extends string ? true : false;

// Regex
const pattern = /^task-(\d+)$/gi;
const escaped = "string with \"quotes\" and \n newline";

// Arrow + promise
const delay = (ms: number): Promise<void> =>
  new Promise((resolve) => setTimeout(resolve, ms));

// Nullish coalescing, optional chaining
function getTaskName(task: Nullable<Task>): string {
  return task?.name ?? "unknown";
}

export { Scheduler, Status, type Task, type TaskId };
