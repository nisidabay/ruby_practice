# permutation

Yields all permutations of elements taken `n` at a time (order matters, no repeats).

```ruby
arr = [1, 2, 3]

# Permutations of 2
arr.permutation(2).to_a # => [[1, 2], [1, 3], [2, 1], [2, 3], [3, 1], [3, 2]]

# All permutations (no argument = full length)
arr.permutation.to_a # => [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]

# Permutations of 1
arr.permutation(1).to_a # => [[1], [2], [3]]

# Permutation of 0
arr.permutation(0).to_a # => [[]]

# With block
arr.permutation(2) { |perm| puts perm.inspect }
```