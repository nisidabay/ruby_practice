# Pattern Matching — Practice Suite

Ruby 3.0+ pattern matching: destructure arrays, hashes, and objects in one step.
Cleaner than if/elsif chains, safer than manual indexing.

> **Prerequisites:** Groups 02 (strings/regex — case/when basics), 03 (collections — arrays/hashes).
> Pattern matching is a Ruby 3.0+ feature. This repo uses Ruby 3.4.8.

## Quick Start

```bash
# Core matching
ruby 01_value_matching.rb               # case/in basics — cleaner than case/when
ruby 02_array_patterns.rb               # Destructure arrays by position
ruby 03_hash_patterns.rb                # Extract hash keys, ignore the rest

# Advanced patterns
ruby 04_pin_operator.rb                 # Match against variable values with ^
ruby 05_alternatives.rb                 # Match this OR that with |
ruby 06_guards.rb                        # Add if/unless conditions to patterns
ruby 07_rightward_assignment.rb         # One-liner destructuring with =>

# Real-world usage
ruby 08_find_patterns.rb                # Find elements anywhere in an array
ruby 09_method_patterns.rb              # Pattern matching in method bodies
ruby 10_structured_data.rb              # Parse complex API responses
```

## Learning Path

### Core Matching (~25 min)

| Script | Concept |
|---|---|
| `01_value_matching.rb` | `case/in` — pattern matching basics |
| `02_array_patterns.rb` | Array patterns: `[first, *rest]` |
| `03_hash_patterns.rb` | Hash patterns: `{key: variable}` |

### Advanced Patterns (~25 min)

| Script | Concept |
|---|---|
| `04_pin_operator.rb` | `^variable` — match against existing value |
| `05_alternatives.rb` | `(A \| B)` — match one of several patterns |
| `06_guards.rb` | `if`/`unless` conditions on patterns |
| `07_rightward_assignment.rb` | `=>` — one-liner destructuring |

### Real-World Usage (~20 min)

| Script | Concept |
|---|---|
| `08_find_patterns.rb` | `[*, target, *]` — find elements in sequences |
| `09_method_patterns.rb` | Pattern matching in method bodies |
| `10_structured_data.rb` | Parse complex nested data (API responses) |

## Common Patterns

```ruby
# Value matching
case status
in 200       then 'Success'
in (301|302) then 'Redirect'
in 404       then 'Not Found'
end

# Array destructuring
case command
in ['create', type, name]  then "Creating #{type} #{name}"
in ['list', *filters]      then "Listing with #{filters}"
end

# Hash destructuring
case response
in { status: 200, body: msg }              then "OK: #{msg}"
in { status: code, error: msg } if code >= 400 then "Error: #{msg}"
end

# Rightward assignment
config => { db: { host: h, port: p } }
puts "DB at #{h}:#{p}"

# Find pattern
case log
in [*, :error, msg, *] then "Found error: #{msg}"
end
```

## Now Build Your Own

Write a `parse_log` method that takes an array of mixed log entries and
returns a structured summary. Use find patterns to extract all errors
and warnings, array patterns for timestamps, and hash patterns for
structured entries.

Example input:
```ruby
log = [
  { timestamp: '10:00', event: 'start' },
  :info, 'connected',
  :error, 'timeout',
  { timestamp: '10:05', event: 'retry' },
  :warn, 'slow response'
]
```
