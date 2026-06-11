# Data & Enumerators — Practice Suite

Immutable value objects, lazy infinite sequences, and advanced iteration patterns.
Ruby 3.2+ features plus enumerator techniques that work in any Ruby version.

> **Prerequisites:** Groups 03 (collections), 06 (blocks/procs), 10 (threads — Fibers).
> `Data` requires Ruby 3.2+. `Enumerator.produce` requires Ruby 2.7+.

## Quick Start

```bash
# Value objects
ruby 01_data_class.rb                   # Data.define — immutable value objects

# Lazy sequences
ruby 02_enumerator_produce.rb           # Infinite sequences on demand
ruby 04_lazy_enumerators.rb             # Process huge datasets in constant memory
ruby 05_custom_enumerator.rb            # Build your own enumerators

# Advanced iteration
ruby 03_enumerator_chaining.rb          # with_index, with_object
ruby 06_external_iterator.rb            # next, peek, rewind — manual control
ruby 07_fiber_scheduler.rb              # Async I/O without callbacks (conceptual)

# Putting it together
ruby 08_lazy_pipeline.rb                # Data + produce + lazy — full pipeline
```

## Learning Path

### Value Objects (~10 min)

| Script | Concept |
|---|---|
| `01_data_class.rb` | `Data.define` — immutable, value equality, `with` for copies |

### Lazy Sequences (~25 min)

| Script | Concept |
|---|---|
| `02_enumerator_produce.rb` | `Enumerator.produce` — infinite lazy sequences |
| `04_lazy_enumerators.rb` | `.lazy` — no intermediate arrays, constant memory |
| `05_custom_enumerator.rb` | `Enumerator.new` — custom generators with Yielder |

### Advanced Iteration (~20 min)

| Script | Concept |
|---|---|
| `03_enumerator_chaining.rb` | `.with_index`, `.with_object` — carry state through iteration |
| `06_external_iterator.rb` | `.next`, `.peek`, `.rewind` — manual iteration control |
| `07_fiber_scheduler.rb` | Fiber Scheduler interface — async I/O (conceptual) |

### Putting It Together (~10 min)

| Script | Concept |
|---|---|
| `08_lazy_pipeline.rb` | `Data` + `produce` + `.lazy` — production pipeline |

## Common Patterns

```ruby
# Data — immutable value objects
Point = Data.define(:x, :y)
a = Point.new(3, 4)
b = a.with(x: 10)  # copy with one field changed

# Enumerator.produce — infinite sequences
ids = Enumerator.produce(1) { |n| n + 1 }
ids.take(5)  # => [1, 2, 3, 4, 5]

# Lazy pipeline — constant memory
(1..1_000_000).lazy.select(&:even?).map { |n| n * n }.take(5).force

# with_object — carry accumulator
words.each.with_object(Hash.new { |h, k| h[k] = [] }) { |w, h| h[w[0]] << w }

# External iterator — manual control
tokens = %w[if x > 10].each
tokens.next  # => "if"
tokens.peek  # => "x"  (look ahead)
```

## Now Build Your Own

Create a `StreamProcessor` that reads a large CSV file lazily, filters rows
by a condition, transforms them with a block, and outputs the first N results.
Use `File.foreach.lazy`, `Data.define` for rows, and `Enumerator.produce` for
a test data generator.

Hint: `File.foreach('data.csv').lazy.map { |l| l.split(',') }` is your starting point.
