# Time, Date & Numbers — Practice Suite

Working with Time, Date, epoch timestamps, timezones, and numeric operations.

## Quick Start

```bash
# Time fundamentals
ruby 01_current_time.rb                 # Time.now — get current date and time
ruby 02_specific_times.rb               # Time.new — create Time for specific dates
ruby 03_time_components.rb              # Extract year, month, day, hour, etc.
ruby 04_time_arithmetic.rb              # Add, subtract, compare Time objects

# Formatting & Parsing
ruby 05_strftime_formatting.rb          # strftime — format Time into readable strings
ruby 06_time_parsing.rb                 # Parse date strings into Time objects

# Advanced
ruby 07_epoch_timestamps.rb             # Unix epoch: seconds since Jan 1, 1970
ruby 08_date_class.rb                   # Date objects (date-only, no time)
ruby 09_timezones.rb                    # UTC, local time, and zone offsets
```

## Learning Path

### Time Objects (~30 min)

| Script | Concept |
|---|---|
| `01_current_time.rb` | `Time.now` — current date and time |
| `02_specific_times.rb` | `Time.new(year, month, day, ...)` |
| `03_time_components.rb` | Extract: `.year`, `.month`, `.day`, `.hour`, `.min`, `.sec` |
| `04_time_arithmetic.rb` | `+` / `-` seconds, comparison operators |

### Formatting & Parsing (~25 min)

| Script | Concept |
|---|---|
| `05_strftime_formatting.rb` | `strftime` directives: `%Y`, `%m`, `%d`, `%H`, `%M`, `%S` |
| `06_time_parsing.rb` | `Time.parse`, `Time.strptime`, `Date.parse` |

### Advanced (~25 min)

| Script | Concept |
|---|---|
| `07_epoch_timestamps.rb` | `.to_i` — Unix timestamp; `Time.at(n)` — from timestamp |
| `08_date_class.rb` | `Date` — date-only objects (requires `require 'date'`) |
| `09_timezones.rb` | `.utc`, `.localtime`, `.getlocal`, zone offsets |

### Numbers (~15 min)

| Script | Concept |
|---|---|
| `floating_point_numbers.rb` | Float division vs integer division |
| `predicate_methods.rb` | `.odd?`, `.even?`, `.positive?`, `.negative?` |
| `the_inequality_operator.rb` | `!=` — not equal to |

## Common Patterns

```ruby
# Current time
now = Time.now                          # 2026-05-31 18:30:00 +0200

# Specific time
t = Time.new(2026, 5, 31, 12, 0, 0)   # May 31, 2026 at noon

# Components
t.year                                  # => 2026
t.month                                 # => 5
t.wday                                  # => 0 (Sunday)

# Arithmetic (seconds)
t + 3600                                # 1 hour later
t - 86400                               # 1 day earlier
t1 < t2                                 # comparison

# Formatting
t.strftime("%Y-%m-%d")                  # => "2026-05-31"
t.strftime("%H:%M:%S")                  # => "12:00:00"

# Epoch
t.to_i                                  # => 1768723200 (Unix timestamp)
Time.at(1768723200)                     # => time from timestamp

# Timezone
Time.now.utc                            # UTC
Time.now.localtime("+09:00")            # Tokyo
```
