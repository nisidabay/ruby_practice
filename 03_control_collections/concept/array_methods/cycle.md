# cycle

Cycles through elements indefinitely, yielding each to the block. Can limit cycles with argument.

```ruby
arr = [1, 2, 3]

# Cycle 2 times
arr.cycle(2) { |n| print n } # prints: 123123

# Returns nil after n cycles
arr.cycle(1) { |n| puts n } # prints: 1, 2, 3

# Returns enumerator if no block
enum = arr.cycle(2) # => #<Enumerator: ...>
enum.to_a # => [1, 2, 3, 1, 2, 3]

# Infinite cycle (use carefully!)
# arr.cycle { |n| puts n } # loops forever
```