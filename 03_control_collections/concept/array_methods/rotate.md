# rotate

Returns a new array with elements rotated (shifted) left by `n` positions.

```ruby
arr = ['a', 'b', 'c', 'd']

# Rotate left by 1 (default)
arr.rotate # => ["b", "c", "d", "a"]

# Rotate left by n
arr.rotate(2) # => ["c", "d", "a", "b"]

# Rotate right (negative n)
arr.rotate(-1) # => ["d", "a", "b", "c"]

# Original is unchanged
arr # => ["a", "b", "c", "d"]
```