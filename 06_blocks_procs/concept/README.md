# Blocks, Procs & Lambdas — Practice Suite

Ruby's closure trifecta: blocks, procs, and lambdas. Each builds on the previous.

Files are in narrative order — read sequentially, not alphabetically.

## Quick Start

```bash
# Blocks: implicit, lightweight, one per method
ruby 01_blocks.rb                       # Blocks eliminate setup/teardown repetition
ruby 05_yield.rb                        # yield patterns: basic, args, return, sandwich

# Procs: stored blocks, reusable
ruby 02_procs.rb                        # Package logic into an object
ruby 06_procs_examples.rb              # Proc creation patterns

# Lambdas: strict procs with argument checking
ruby 03_lambdas.rb                      # Argument checking + safe returns

# Advanced
ruby 04_advanced.rb                     # & operator, anonymous parameters
ruby exercises.rb                       # Consolidation exercises
```

## Learning Path

### Blocks (~25 min)

| Script | Concept |
|---|---|
| `01_blocks.rb` | Blocks eliminate setup/teardown repetition |
| `05_yield.rb` | `yield` patterns: basic, args, return value, `block_given?`, sandwich |

### Procs (~20 min)

| Script | Concept |
|---|---|
| `02_procs.rb` | Stored blocks — package logic into a `Proc` object |
| `06_procs_examples.rb` | Creating procs: `Proc.new`, `proc`, `lambda`, `&` |

### Lambdas (~15 min)

| Script | Concept |
|---|---|
| `03_lambdas.rb` | Strict blocks — argument checking + `return` stays local |

### Advanced (~15 min)

| Script | Concept |
|---|---|
| `04_advanced.rb` | `&` operator: block→proc and proc→block conversions |

## Key Differences

| Feature | Block | Proc | Lambda |
|---|---|---|---|
| Creation | Implicit (`{}`/`do..end`) | `Proc.new` / `proc` | `lambda` / `->` |
| Object? | No | Yes | Yes |
| Storable? | Only via `&` | Yes | Yes |
| Arity check | No | No (extra args → nil) | Yes (`ArgumentError`) |
| `return` behavior | Returns from enclosing method | Returns from enclosing method | Returns from lambda only |
| Multiple per method | 1 | ∞ | ∞ |

## Common Patterns

```ruby
# Block (implicit)
[1, 2, 3].each { |n| puts n }

# Block with yield
def log(msg)
  puts "[#{Time.now}] #{msg}"
  yield if block_given?
end

# Proc (storable)
doubler = Proc.new { |n| n * 2 }
[1, 2, 3].map(&doubler)                # => [2, 4, 6]

# Lambda (strict)
increment = ->(n) { n + 1 }
increment.call(5)                        # => 6
increment.call(1, 2)                     # ArgumentError!

# & operator: block → proc
def capture(&block)
  block.class                           # => Proc
end
```
