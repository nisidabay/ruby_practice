# repeated_permutation

Yields all permutations of elements taken `n` at a time, allowing repeated elements.

```ruby
arr = [1, 2]

# Repeated permutations of 2
arr.repeated_permutation(2).to_a # => [[1, 1], [1, 2], [2, 1], [2, 2]]

# Repeated permutations of 3
arr.repeated_permutation(3).to_a # => [[1, 1, 1], [1, 1, 2], [1, 2, 1], [1, 2, 2], [2, 1, 1], [2, 1, 2], [2, 2, 1], [2, 2, 2]]

# No argument defaults to array length
[1, 2].repeated_permutation.to_a # => same as repeated_permutation(2)

# Useful for generating all possible sequences
# With block
arr.repeated_permutation(2) { |perm| puts perm.inspect }
```