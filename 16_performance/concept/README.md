# Performance — Benchmark, Lazy Enumerators, Data Structures

Write efficient Ruby scripts that scale. Pure stdlib: `benchmark`, `set`, `Enumerator::Lazy`.

## Quick Start

```bash
ruby 01_benchmark.rb                     # Array vs Set: 2500x difference
ruby 02_lazy_enumerator.rb               # Process 1M items, only generate 5
ruby 03_set_vs_array.rb                  # O(1) lookups, deduplication

# Exercises
ruby ../exercises.rb                     # 3 exercises + BONUS
```

## Learning Path

### Measurement (~10 min)

| Script | Concept |
|---|---|
| `01_benchmark.rb` | `Benchmark.bm` — compare Array vs Set lookups |

### Efficient Processing (~10 min)

| Script | Concept |
|---|---|
| `02_lazy_enumerator.rb` | `.lazy` pipeline — no intermediate arrays |

### Data Structures (~10 min)

| Script | Concept |
|---|---|
| `03_set_vs_array.rb` | `Set` for O(1) membership, `Hash` keys, dedup |

## Common Patterns

```ruby
# Benchmark
require "benchmark"
Benchmark.bm { |x| x.report("label") { ... } }

# Lazy pipeline
(1..1_000_000).lazy.map { |n| n * 2 }.select(&:even?).first(10)

# Set for fast lookups
require "set"
set = data.to_set
set.include?(needle)  # O(1) vs Array O(n)
```

## Project Tool

```bash
# Time a command, optionally multiple runs
../project/ftimer ls -la /tmp
../project/ftimer -n 10 curl -s https://httpbin.org/get
```
