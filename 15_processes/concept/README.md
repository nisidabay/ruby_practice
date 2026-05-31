# Process Management — Open3, Fork, Signals

Run system commands, spawn child processes, and handle Unix signals.
Pure stdlib: `open3`, `timeout`, `Process`, `Signal`.

## Quick Start

```bash
# System commands
ruby 01_open3_capture.rb                # capture stdout/stderr/status
ruby 02_backticks_vs_system.rb          # backticks vs system()

# Process management
ruby 03_fork_spawn_exec.rb              # fork, spawn, Process.wait
ruby 04_signals_trap.rb                 # trap SIGINT/SIGTERM

# Exercises
ruby ../exercises.rb                    # 3 exercises + BONUS
```

## Learning Path

### Running Commands (~15 min)

| Script | Concept |
|---|---|
| `01_open3_capture.rb` | `Open3.capture3` — stdout, stderr, exit status all separate |
| `02_backticks_vs_system.rb` | Backticks capture output; `system()` returns boolean |

### Process Control (~20 min)

| Script | Concept |
|---|---|
| `03_fork_spawn_exec.rb` | `fork` (clone process), `spawn` (new process), `Process.wait` |
| `04_signals_trap.rb` | `trap("INT")`, `trap("TERM")` — graceful shutdown |

## Common Patterns

```ruby
# Safe command execution
require "open3"
stdout, stderr, status = Open3.capture3("ls", "-la", "/tmp")
abort "Error: #{stderr}" unless status.success?

# Spawn and wait
pid = spawn("convert", "in.png", "out.jpg")
Process.wait(pid)

# Fork for parallelism
pid = fork do
  # heavy work in child
  exit 0
end
Process.wait(pid)

# Signal handling
trap("INT")  { puts "Interrupted"; exit 0 }
trap("TERM") { puts "Terminated";  exit 0 }
```

## Project Tool

```bash
# Run a command with timeout and status report
../project/frun ls -la /tmp
../project/frun --timeout 5 curl https://example.com
```

## Now Build Your Own

Write a `parallel_build` script that takes a list of directories and
runs `make` in each one simultaneously using `fork`. Capture each
child's stdout/stderr with `Open3.capture3` and report which builds
succeeded or failed.
