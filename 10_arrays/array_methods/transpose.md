# transpose

Transposes an array of arrays (swaps rows and columns).

```ruby
arr = [[1, 2, 3], [4, 5, 6]]

arr.transpose # => [[1, 4], [2, 5], [3, 6]]

# All sub-arrays must have same length
[[1, 2], [3, 4], [5, 6]].transpose # => [[1, 3, 5], [2, 4, 6]]

# Single row
[[1, 2, 3]].transpose # => [[1], [2], [3]]

# Matrix-like data
matrix = [[1, 2], [3, 4]]
matrix.transpose # => [[1, 3], [2, 4]]

# Raises error if lengths differ
[[1, 2], [3]].transpose # => IndexError: element size differs
```