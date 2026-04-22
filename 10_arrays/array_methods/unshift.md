# unshift

Adds elements to the beginning of the array (destructive).

```ruby
arr = [3, 4, 5]

# Add single element
arr.unshift(2) # => [2, 3, 4, 5]

# Add multiple elements
arr.unshift(0, 1) # => [0, 1, 2, 3, 4, 5]

# Original is modified
arr # => [0, 1, 2, 3, 4, 5]
```

**Alias:** `prepend`