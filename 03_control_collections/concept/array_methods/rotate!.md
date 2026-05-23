# rotate!

Rotates the array in place (destructive).

```ruby
arr = ['a', 'b', 'c', 'd']

# Rotate left by 1 (default)
arr.rotate! # => ["b", "c", "d", "a"]

# Rotate by n positions
arr = ['a', 'b', 'c', 'd']
arr.rotate!(2) # => ["c", "d", "a", "b"]

# Rotate right (negative)
arr = ['a', 'b', 'c', 'd']
arr.rotate!(-1) # => ["d", "a", "b", "c"]

# Original is modified
arr # => ["d", "a", "b", "c"]
```