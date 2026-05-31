# Control Flow & Collections — Practice Suite

Conditionals, loops, iteration, and data structures — arrays, hashes, sets, structs.

## Quick Start

```bash
# Control flow
ruby if_else.rb                         # Multi-way branching
ruby if_or.rb                           # Inline if with ||
ruby case.rb                            # Case/when for value matching
ruby unless.rb                          # Inverted conditionals

# Loops
ruby while.rb                           # Loop while condition holds
ruby until.rb                           # Loop until condition becomes true
ruby loop_do.rb                         # Infinite loop with break
ruby for_loop.rb                        # For loops (legacy — prefer .each)

# Iteration
ruby each.rb                            # Iterate without index management
ruby each_with_index.rb                 # Index + value in one pass
ruby times_upto_downto_step.rb          # Numeric iterators
ruby map.rb                             # Transform every element
ruby select.rb                          # Keep elements that match
ruby reduce.rb                          # Accumulate to a single value
ruby break.rb                           # Exit a loop immediately
ruby next.rb                            # Skip this iteration
```

## Learning Path

### Control Flow (~20 min)

| Script | Concept |
|---|---|
| `if_else.rb` | Multi-way branching without nested ternaries |
| `if_or.rb` | Inline if with `||` |
| `case.rb` | `case/when` cleaner than if/elsif for one value |
| `string_theory.rb` | Predicates with `||` |

### Loops & Iteration (~30 min)

| Script | Concept |
|---|---|
| `loops.rb` | `while`, `until`, `for`, modifiers |
| `looping_numbers.rb` | `times`, `upto`, `downto`, `step` |
| `each.rb` | Iterate without index management |
| `each_with_index.rb` | Access current index during iteration |
| `map.rb` | Transform every element (aka `collect`) |
| `select.rb` | Keep elements that match (aka `filter`) |
| `partition.rb` | Split into matching/non-matching arrays |
| `reduce.rb` | Accumulate elements to a single value |
| `break.rb` / `next.rb` | Exit loop early / skip iteration |

### Collections (~40 min)

| Script | Concept |
|---|---|
| `arrays.rb` | Array reference catalog |
| `array_new.rb` | `Array.new` — size, default value, block |
| `hashes.rb` | Hash basics and common patterns |
| `hash_methods.rb` | Hash reference catalog |
| `config_keys_check.rb` | Hash keys as Set — find missing keys with subtraction |
| `ranges.rb` | Inclusive `..` vs exclusive `...` |
| `structs.rb` | Struct — lightweight data class |
| `sets.rb` | Set — unique element collection |
| `enumerable.rb` | Enumerable module — works on Array, Hash, Range, Set |

### Data Structures (~45 min)

| Script | Concept |
|---|---|
| `01_array_stack.rb` | Stack (LIFO) — push/pop, O(1) |
| `02_linked_list.rb` | Linked list — O(1) insert, O(n) access |
| `03_queue.rb` | Queue (FIFO) — enqueue/dequeue |
| `04_binary_search_tree.rb` | BST — O(log n) search/insert |
| `05_min_heap.rb` | Min Heap — O(log n) push/pop, O(1) peek |
| `06_graph.rb` | Graph — adjacency list + BFS |

## Common Patterns

```ruby
# Iteration
[1, 2, 3].each { |n| puts n }
[1, 2, 3].map { |n| n * 2 }            # => [2, 4, 6]
[1, 2, 3, 4].select(&:even?)           # => [2, 4]
[1, 2, 3].reduce(0) { |sum, n| sum + n } # => 6

# Hash
h = {a: 1, b: 2}
h[:a]                                    # => 1
h.key?(:c)                               # => false

# Range
(1..5).to_a                              # => [1, 2, 3, 4, 5]
(1...5).to_a                             # => [1, 2, 3, 4]
```
