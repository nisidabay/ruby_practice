# Threads & Concurrency — Practice Suite

Threads, mutexes, queues, fibers, ractors, and concurrency primitives.

## Quick Start

```bash
# Threading fundamentals
ruby 01_basic_thread.rb                 # Thread.new — concurrent execution
ruby 03_mutex.rb                        # Mutex#synchronize — prevent data races
ruby 02_data_race.rb                    # Shared state without locks = lost updates

# Queues
ruby 01_queue.rb                        # Thread-safe FIFO — pop blocks when empty
ruby 02_sized_queue.rb                  # SizedQueue — push blocks when full
ruby 05_queue_close_multi_worker.rb     # Queue#close + multiple consumers

# Concurrency models
ruby 03_fiber.rb                        # Cooperative concurrency — you control switching
ruby 04_ractor.rb                       # True OS threads with isolated state

# Advanced
ruby 04_condition_variable.rb           # Threads wait until signal from another
ruby 05_thread_local_vars.rb            # Thread#[] — per-thread storage
ruby 06_thread_pool.rb                  # Worker pool pulling from a shared queue

# Hacking scripts
ruby 05_port_scanner_threaded.rb        # Queue + Mutex + Timeout port scanner
```

## Learning Path

### Threads (~25 min)

| Script | Concept |
|---|---|
| `01_basic_thread.rb` | `Thread.new` — concurrent execution in one process |
| `03_mutex.rb` | `Mutex#synchronize` — only one thread in the block at a time |
| `02_data_race.rb` | Shared state without locks → lost updates |

### Queues (~25 min)

| Script | Concept |
|---|---|
| `01_queue.rb` | `Queue` — thread-safe FIFO; `pop` blocks when empty |
| `02_sized_queue.rb` | `SizedQueue` — max capacity; `push` blocks when full |
| `05_queue_close_multi_worker.rb` | `Queue#close` + multiple consumers — idiomatic worker pattern |

### Fibers & Ractors (~25 min)

| Script | Concept |
|---|---|
| `03_fiber.rb` | Cooperative concurrency — you control exactly when switching happens |
| `04_ractor.rb` | True OS threads with isolated state (no GIL for CPU-bound work) |

### Advanced (~20 min)

| Script | Concept |
|---|---|
| `04_condition_variable.rb` | Threads wait until another thread signals |
| `05_thread_local_vars.rb` | `Thread#[]` / `Thread#[]=` — per-thread storage |
| `06_thread_pool.rb` | Worker pool: Mutex + ConditionVariable + Queue |

### Hacking Scripts (~15 min)

| Script | Concept |
|---|---|
| `05_port_scanner_threaded.rb` | `Queue` + `Mutex` + `Timeout` applied to TCP scanning |

## Common Patterns

```ruby
# Basic thread
t = Thread.new do
  sleep 1
  puts "done"
end
t.join                                  # Wait for thread to finish

# Mutex — prevent races
mutex = Mutex.new
counter = 0

threads = 10.times.map do
  Thread.new do
    mutex.synchronize { counter += 1 }
  end
end
threads.each(&:join)
puts counter                            # => 10 (guaranteed)

# Queue — producer/consumer
queue = Queue.new

producer = Thread.new do
  5.times { |i| queue << i }
  queue.close
end

consumer = Thread.new do
  while (item = queue.pop)
    puts item
  end
end

# Fiber — cooperative
fiber = Fiber.new do
  Fiber.yield 1
  Fiber.yield 2
  3
end

fiber.resume                            # => 1
fiber.resume                            # => 2
fiber.resume                            # => 3
```

## Now Build Your Own

Write a parallel file checker: given a list of file paths, spawn a
thread for each one that checks if the file exists and reports its
size. Use a `Queue` to collect results and print them in the main thread.
