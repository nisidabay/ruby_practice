# values_at

Returns an array containing values at specified indices, with `nil` for out-of-bounds.

```ruby
arr = ['a', 'b', 'c', 'd', 'e']

# Multiple indices
arr.values_at(0, 2, 4) # => ["a", "c", "e"]

# Duplicate indices allowed
arr.values_at(0, 0, 1) # => ["a", "a", "b"]

# Negative indices
arr.values_at(0, -1) # => ["a", "e"]

# Out of bounds returns nil
arr.values_at(0, 10) # => ["a", nil]
```