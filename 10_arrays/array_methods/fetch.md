# fetch

Returns the element at a given index, raising an error or returning a default if out of bounds.

```ruby
arr = ['a', 'b', 'c']

# Normal fetch
arr.fetch(1) # => "b"

# Negative index
arr.fetch(-1) # => "c"

# With default value for out of bounds
arr.fetch(10, 'default') # => "default"

# With block for out of bounds
arr.fetch(10) { |i| "index #{i} out of bounds" } # => "index 10 out of bounds"

# Raises IndexError without default
arr.fetch(10) # => IndexError: index 10 outside of array bounds
```