# prepend

Adds elements to the beginning of the array (destructive).

```ruby
arr = [3, 4, 5]

# Prepend single element
arr.prepend(2) # => [2, 3, 4, 5]

# Prepend multiple elements
arr = [4, 5, 6]
arr.prepend(1, 2, 3) # => [1, 2, 3, 4, 5, 6]

# Works identically to #unshift
```

**Alias:** `unshift`