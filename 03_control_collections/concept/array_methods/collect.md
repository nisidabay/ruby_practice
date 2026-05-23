# collect

Returns a new array with results of running the block on each element.

```ruby
arr = [1, 2, 3, 4, 5]

# Transform elements
arr.collect { |n| n ** 2 } # => [1, 4, 9, 16, 25]

# Original unchanged
arr # => [1, 2, 3, 4, 5]

# Works identically to #map
words = ['apple', 'banana', 'cherry']
words.collect { |w| w.length } # => [5, 6, 6]

# Using symbol shortcut
['a', 'b', 'c'].collect(&:upcase) # => ["A", "B", "C"]
```

**Alias:** `map`