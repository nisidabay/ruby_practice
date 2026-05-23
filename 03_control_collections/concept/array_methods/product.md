# product

Returns an array of all combinations of elements from self and given arrays.

```ruby
# Cartesian product
[1, 2].product([3, 4]) # => [[1, 3], [1, 4], [2, 3], [2, 4]]

# With multiple arrays
[1, 2].product([3], [4]) # => [[1, 3, 4], [2, 3, 4]]

# No arguments: returns single-element arrays
[1, 2, 3].product # => [[1], [2], [3]]

# Useful for grid generation
x = [0, 1, 2]
y = [0, 1]
x.product(y) # => [[0, 0], [0, 1], [1, 0], [1, 1], [2, 0], [2, 1]]
```