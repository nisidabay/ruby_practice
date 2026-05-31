# Exceptions & Debugging — Practice Suite

Raising, rescuing, debugging tools, and the Ruby execution model.

## Quick Start

```bash
# Raise & rescue
ruby 01_raise_basics.rb                 # raise stops execution, sends message up stack
ruby 04_rescue_hierarchy.rb             # rescue order: most specific first
ruby 03_ensure_retry.rb                 # ensure runs always; retry reboots begin block

# Custom exceptions
ruby 02_custom_exceptions.rb            # Define your own error classes

# Debugging
ruby debug_1.rb                         # binding.break — suspend in-place
ruby 02_binding_irb.rb                  # Drop into interactive REPL mid-execution
ruby 04_global_debug.rb                 # $DEBUG flag: conditional output

# Stack inspection
ruby 03_caller_warn.rb                  # caller: who called me? warn: errors to stderr
ruby 05_caller_locations.rb             # Structured stack inspection
ruby 06_tracepoint.rb                   # Hook into Ruby's execution events
```

## Learning Path

### Raise & Rescue (~30 min)

| Script | Concept |
|---|---|
| `01_raise_basics.rb` | `raise` stops execution and sends a message up the stack |
| `04_rescue_hierarchy.rb` | Rescue order matters — most specific first |
| `03_ensure_retry.rb` | `ensure` runs no matter what; `retry` reboots the `begin` block |
| `02_custom_exceptions.rb` | Define your own error classes under `StandardError` |

### Debugging Tools (~25 min)

| Script | Concept |
|---|---|
| `debug_1.rb` | `binding.break` — suspend execution in-place (Ruby 3.2+) |
| `02_binding_irb.rb` | `binding.irb` — drop into REPL mid-execution |
| `04_global_debug.rb` | `$DEBUG` flag — conditional output without changing code |
| `debug_and_pp.rb` | `pp` — pretty print nested data; debugger setup |

### Stack Inspection (~20 min)

| Script | Concept |
|---|---|
| `03_caller_warn.rb` | `caller` — who called me? `warn` — errors to stderr |
| `05_caller_locations.rb` | `caller_locations` — structured stack inspection |
| `06_tracepoint.rb` | `TracePoint` — hook into Ruby's execution events |

## Common Patterns

```ruby
# Basic rescue
begin
  File.read("nonexistent")
rescue Errno::ENOENT => e
  puts "File not found: #{e.message}"
end

# ensure — cleanup always runs
file = File.open("data.txt")
begin
  # ... work with file
ensure
  file.close
end

# Custom exception
class ValidationError < StandardError; end

raise ValidationError, "Name is required" unless name

# retry — try again
attempts = 0
begin
  attempts += 1
  api.call
rescue TimeoutError
  retry if attempts < 3
end

# Rescue as expression
result = begin
  Integer("42")
rescue ArgumentError
  0
end
```

## Now Build Your Own

Write a `safe_read` method that tries to read a file 3 times with
exponential backoff (1s, 2s, 4s). If all attempts fail, raise a
custom `PersistentIOError`. Use `retry` and a counter.
