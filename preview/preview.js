// JavaScript syntax demonstration for theme preview.

"use strict";

const MAX_RETRY = 3;
const PI = 3.14159;
const HEX_FLAG = 0xff;
const GREETING = "hello, world";

class Task {
  #meta = {};

  constructor(id, name, tags = []) {
    this.id = id;
    this.name = name;
    this.status = "pending";
    this.tags = tags;
    this.createdAt = new Date();
  }

  get displayName() {
    return `Task#${this.id} '${this.name}'`;
  }

  set statusValue(value) {
    if (!["pending", "running", "done"].includes(value)) {
      throw new Error(`unknown status: ${value}`);
    }
    this.status = value;
  }

  execute() {
    this.#meta.attempt = (this.#meta.attempt ?? 0) + 1;
    this.status = "done";
    return { ...this.#meta };
  }

  toJSON() {
    return { id: this.id, name: this.name, status: this.status };
  }
}

// Inheritance
class PriorityTask extends Task {
  constructor(id, name, priority = 0) {
    super(id, name);
    this.priority = priority;
  }
}

// Symbol, WeakMap
const taskKey = Symbol("task");
const cache = new WeakMap();

// Async/await, destructuring
async function processAll(tasks) {
  const results = [];

  for (const [i, task] of tasks.entries()) {
    task.status = "running";

    for (let retry = 0; retry < MAX_RETRY; retry++) {
      try {
        const meta = await Promise.resolve(task.execute());
        results.push({ task: task.displayName, meta, ok: true });
        break;
      } catch (err) {
        console.error(`retry ${retry + 1}:`, err.message);
        if (retry === MAX_RETRY - 1) throw err;
      }
    }
  }

  return results;
}

// Generator
function* idGenerator(start = 1) {
  let id = start;
  while (true) {
    yield id++;
  }
}

// Proxy, Reflect
const handler = {
  get(target, prop, receiver) {
    console.log(`access: ${String(prop)}`);
    return Reflect.get(target, prop, receiver);
  },
  set(target, prop, value) {
    console.log(`write: ${String(prop)} = ${value}`);
    return Reflect.set(target, prop, value);
  },
};

// Regex, template literals
const pattern = /^task-(?<id>\d+)$/gi;
const escaped = "string with \"quotes\" and \n newline";
const template = `total: ${MAX_RETRY}, number: ${PI.toFixed(2)}`;

// Nullish, optional chaining, spread
function formatTask(task) {
  const name = task?.name ?? "unknown";
  const tags = [...(task?.tags ?? [])];
  return { name, tags, timestamp: Date.now() };
}

// Array methods
const numbers = Array.from({ length: 10 }, (_, i) => i);
const evens = numbers.filter((n) => n % 2 === 0);
const doubled = evens.map((n) => n * 2);
const sum = doubled.reduce((acc, n) => acc + n, 0);

// Promise.all, dynamic import
async function main() {
  const gen = idGenerator();
  const tasks = ["build", "test", "deploy"].map(
    (name) => new Task(gen.next().value, name)
  );

  const results = await processAll(tasks);
  console.log(JSON.stringify(results, null, 2));
}

export { Task, PriorityTask, processAll };
