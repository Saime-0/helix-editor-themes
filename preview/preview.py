# Демонстрация синтаксиса Python для проверки темы.

from __future__ import annotations

import asyncio
import json
import math
from dataclasses import dataclass, field
from enum import Enum, auto
from pathlib import Path
from typing import Any, Callable, TypeVar

# Константы
MAX_RETRY: int = 3
PI: float = 3.14159
HEX_MASK: int = 0xFF00
GREETING: str = "привет, мир"


class Status(Enum):
    """Статус задачи."""
    PENDING = auto()
    RUNNING = auto()
    DONE = auto()
    FAILED = auto()


@dataclass
class Task:
    """Единица работы."""
    id: int
    name: str
    status: Status = Status.PENDING
    tags: list[str] = field(default_factory=list)
    meta: dict[str, Any] = field(default_factory=dict)

    def __post_init__(self) -> None:
        if not self.name:
            raise ValueError("имя задачи не может быть пустым")

    def __str__(self) -> str:
        return f"Task#{self.id} '{self.name}' [{self.status.name}]"

    @property
    def is_done(self) -> bool:
        return self.status == Status.DONE

    def execute(self) -> None:
        """Выполняет задачу."""
        self.status = Status.RUNNING
        self.meta["attempt"] = self.meta.get("attempt", 0) + 1
        self.status = Status.DONE


class TaskError(Exception):
    """Ошибка выполнения задачи."""


T = TypeVar("T")


class Scheduler:
    """Планировщик задач."""

    def __init__(self, workers: int = 4) -> None:
        self._tasks: list[Task] = []
        self._workers = workers

    def submit(self, name: str, *tags: str) -> Task:
        task = Task(
            id=len(self._tasks) + 1,
            name=name,
            tags=list(tags),
        )
        self._tasks.append(task)
        return task

    def process(self) -> list[str]:
        results: list[str] = []

        for task in self._tasks:
            for retry in range(MAX_RETRY):
                try:
                    task.execute()
                    results.append(f"{task}: ok")
                    break
                except Exception as exc:
                    if retry == MAX_RETRY - 1:
                        raise TaskError(f"не удалось: {exc}") from exc
                    print(f"retry {retry + 1}: {exc}")

        return results

    # Generics
    def filter(self, predicate: Callable[[Task], bool]) -> list[Task]:
        return [t for t in self._tasks if predicate(t)]


# Pattern matching (3.10+)
def describe_status(status: Status) -> str:
    match status:
        case Status.PENDING:
            return "ожидание"
        case Status.RUNNING:
            return "выполняется"
        case Status.DONE:
            return "готово"
        case _:
            return "неизвестно"


# Async
async def fetch_task(task_id: int) -> Task:
    await asyncio.sleep(0.1)
    return Task(id=task_id, name=f"async-{task_id}")


# Comprehensions, walrus, f-strings
def summary(tasks: list[Task]) -> str:
    done = [t.name for t in tasks if t.is_done]
    counts = {s: sum(1 for t in tasks if t.status == s) for s in Status}

    if (total := len(done)) > 0:
        return f"завершено {total}: {', '.join(done)}"
    return "нет завершённых задач"


# Decorators
def retry(times: int = 3) -> Callable:
    def decorator(func: Callable) -> Callable:
        def wrapper(*args: Any, **kwargs: Any) -> Any:
            for attempt in range(times):
                try:
                    return func(*args, **kwargs)
                except Exception:
                    if attempt == times - 1:
                        raise
        return wrapper
    return decorator


# Lambda, map, filter
transform = lambda x: x * 2 + 1
numbers = list(map(transform, range(10)))
evens = list(filter(lambda n: n % 2 == 0, numbers))

# Multiline string, raw string, bytes
QUERY = """
    SELECT id, name, status
    FROM tasks
    WHERE status = 'done'
    ORDER BY id DESC
"""
RAW_PATH = r"C:\Users\saime\themes"
BINARY = b"\x00\xff\x42"

# Context manager, math
angle = math.pi / 4
result = math.sin(angle) ** 2 + math.cos(angle) ** 2  # == 1.0

if __name__ == "__main__":
    s = Scheduler(workers=2)
    s.submit("build", "ci", "docker")
    s.submit("test", "ci")
    s.submit("deploy", "prod")
    print(s.process())
