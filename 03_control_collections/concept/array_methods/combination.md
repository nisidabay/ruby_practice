# combination

Yields all combinations of elements taken `n` at a time (order preserved, no repeats).

```ruby
arr = [1, 2, 3, 4]

# Combinations of 2
arr.combination(2).to_a # => [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]

# Combinations of 1
arr.combination(1).to_a # => [[1], [2], [3], [4]]

# Combinations of 0 (empty array)
arr.combination(0).to_a # => [[]]

# Combinations larger than array
arr.combination(5).to_a # => [] (impossible)

# With block
arr.combination(2) { |combo| puts combo.inspect }
```