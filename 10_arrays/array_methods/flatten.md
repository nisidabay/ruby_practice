# flatten

## Returns a new array that is a one-dimensional flattening of nested arrays.

```ruby
# Nested arrays
arr = [1, [2, [3, 4]], [5, 6]]
arr.flatten # => [1, 2, 3, 4, 5, 6]

# Limit depth of flattening
arr.flatten(1) # => [1, 2, [3, 4], 5, 6]

# Already flat
[1, 2, 3].flatten # => [1, 2, 3]

# Original is unchanged
arr # => [1, [2, [3, 4]], [5, 6]]
```
