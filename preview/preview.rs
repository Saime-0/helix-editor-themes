// Демонстрация синтаксиса Rust для проверки темы.

use std::collections::HashMap;
use std::fmt;
use std::sync::{Arc, Mutex};

/// Статус задачи.
#[derive(Debug, Clone, Copy, PartialEq)]
pub enum Status {
    Pending,
    Running,
    Done,
    Failed(u8),
}

/// Задача с метаданными.
#[derive(Debug)]
pub struct Task {
    pub id: u64,
    pub name: String,
    pub status: Status,
    tags: Vec<String>,
    meta: HashMap<String, serde_json::Value>,
}

const MAX_RETRY: u8 = 3;
const PI: f64 = 3.14159_265_358_979;
const HEX_MASK: u32 = 0xFF00_FF00;

impl Task {
    pub fn new(id: u64, name: &str) -> Self {
        Self {
            id,
            name: name.to_string(),
            status: Status::Pending,
            tags: Vec::new(),
            meta: HashMap::new(),
        }
    }

    pub fn with_tags(mut self, tags: &[&str]) -> Self {
        self.tags = tags.iter().map(|s| s.to_string()).collect();
        self
    }

    fn execute(&mut self) -> Result<(), TaskError> {
        if self.name.is_empty() {
            return Err(TaskError::EmptyName);
        }
        self.status = Status::Running;
        self.meta.insert("attempt".into(), serde_json::json!(1));
        self.status = Status::Done;
        Ok(())
    }
}

impl fmt::Display for Task {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "Task#{} '{}' [{:?}]", self.id, self.name, self.status)
    }
}

/// Ошибки задачи.
#[derive(Debug, thiserror::Error)]
pub enum TaskError {
    #[error("пустое имя задачи")]
    EmptyName,
    #[error("превышен лимит ретраев ({0})")]
    RetryExhausted(u8),
    #[error("внутренняя ошибка: {0}")]
    Internal(String),
}

/// Планировщик с потокобезопасным доступом.
pub struct Scheduler {
    tasks: Arc<Mutex<Vec<Task>>>,
    workers: usize,
}

impl Scheduler {
    pub fn new(workers: usize) -> Self {
        Self {
            tasks: Arc::new(Mutex::new(Vec::new())),
            workers,
        }
    }

    pub fn submit(&self, name: &str) -> u64 {
        let mut tasks = self.tasks.lock().unwrap();
        let id = tasks.len() as u64 + 1;
        tasks.push(Task::new(id, name));
        id
    }

    pub fn process(&self) -> Result<Vec<String>, TaskError> {
        let mut tasks = self.tasks.lock().unwrap();
        let mut completed = Vec::new();

        for task in tasks.iter_mut() {
            for retry in 0..MAX_RETRY {
                match task.execute() {
                    Ok(()) => {
                        completed.push(format!("{}", task));
                        break;
                    }
                    Err(e) if retry < MAX_RETRY - 1 => {
                        eprintln!("retry {}: {}", retry + 1, e);
                        task.status = Status::Failed(retry);
                        continue;
                    }
                    Err(e) => return Err(e),
                }
            }
        }

        Ok(completed)
    }
}

// Generics + trait bounds
fn filter<T, F>(items: &[T], predicate: F) -> Vec<&T>
where
    F: Fn(&T) -> bool,
{
    items.iter().filter(|item| predicate(item)).collect()
}

// Closures, iterators, pattern matching
fn summary(tasks: &[Task]) -> String {
    tasks
        .iter()
        .filter_map(|t| match t.status {
            Status::Done => Some(t.name.as_str()),
            Status::Failed(n) => Some(if n > 1 { "failed" } else { "retry" }),
            _ => None,
        })
        .collect::<Vec<_>>()
        .join(", ")
}

// Async
async fn fetch_task(id: u64) -> Result<Task, TaskError> {
    let task = Task::new(id, &format!("async-task-{}", id));
    tokio::time::sleep(std::time::Duration::from_millis(100)).await;
    Ok(task)
}
