# find_index

Returns the index of the first matching element, or `nil` if not found.

```ruby
arr = [1, 2, 3, 4, 5]

# Find index by value
arr.find_index(3) # => 2

# Find index with block
arr.find_index { |n| n >= 3 } # => 2

# Works identically to #index
```

**Alias:** `index`