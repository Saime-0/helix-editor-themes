// Package preview demonstrates all Go syntax elements.
package preview

import (
	"context"
	"fmt"
	"math"
	"strings"
	"sync"
	"time"
)

// Status represents a task state.
type Status int

const (
	Pending  Status = iota // pending
	Running                // running
	Done                   // done
	maxRetry        = 3
	piValue         = 3.14159
	hexFlag         = 0xFF
	greeting        = "hello, world"
)

// Task describes a unit of work.
type Task struct {
	ID        int64             `json:"id"`
	Name      string            `json:"name"`
	Status    Status            `json:"status"`
	Tags      []string          `json:"tags,omitempty"`
	Meta      map[string]any    `json:"meta"`
	CreatedAt time.Time         `json:"created_at"`
	cancel    context.CancelFunc
}

// Runner is an executor interface.
type Runner interface {
	Run(ctx context.Context, task *Task) error
	Stop() error
}

// Scheduler manages tasks.
type Scheduler struct {
	mu      sync.RWMutex
	tasks   []*Task
	workers int
	done    chan struct{}
}

// NewScheduler creates a scheduler.
func NewScheduler(workers int) *Scheduler {
	return &Scheduler{
		workers: workers,
		done:    make(chan struct{}),
	}
}

// Submit adds a task.
func (s *Scheduler) Submit(name string, tags ...string) *Task {
	s.mu.Lock()
	defer s.mu.Unlock()

	t := &Task{
		ID:        int64(len(s.tasks) + 1),
		Name:      name,
		Status:    Pending,
		Tags:      tags,
		Meta:      make(map[string]any),
		CreatedAt: time.Now(),
	}
	s.tasks = append(s.tasks, t)
	return t
}

// Process handles tasks with retries.
func (s *Scheduler) Process(ctx context.Context) error {
	for i, task := range s.tasks {
		select {
		case <-ctx.Done():
			return ctx.Err()
		default:
		}

		task.Status = Running

		for retry := 0; retry < maxRetry; retry++ {
			if err := s.execute(task); err != nil {
				fmt.Printf("task %d/%d error (attempt %d): %v\n",
					i+1, len(s.tasks), retry+1, err)
				continue
			}
			break
		}

		task.Status = Done
	}

	// String operations
	names := make([]string, 0, len(s.tasks))
	for _, t := range s.tasks {
		names = append(names, t.Name)
	}
	summary := strings.Join(names, ", ")
	fmt.Printf("completed: [%s]\n", summary)

	// Numbers and math
	angle := math.Pi / 4
	sin := math.Sin(angle)
	_ = sin

	return nil
}

func (s *Scheduler) execute(t *Task) error {
	if t == nil {
		return fmt.Errorf("task must not be nil")
	}
	t.Meta["executed_at"] = time.Now().Unix()
	return nil
}

// Generics
func Filter[T any](slice []T, predicate func(T) bool) []T {
	result := make([]T, 0)
	for _, item := range slice {
		if predicate(item) {
			result = append(result, item)
		}
	}
	return result
}

// Goroutine + channel
func fanOut(input <-chan int, workers int) <-chan int {
	out := make(chan int)
	var wg sync.WaitGroup
	for w := 0; w < workers; w++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			for n := range input {
				out <- n * n
			}
		}()
	}
	go func() {
		wg.Wait()
		close(out)
	}()
	return out
}
