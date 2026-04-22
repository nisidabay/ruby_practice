# map

Returns a new array with results of running the block on each element.

```ruby
arr = [1, 2, 3, 4, 5]

# Transform elements
arr.map { |n| n * 2 } # => [2, 4, 6, 8, 10]

# Original unchanged
arr # => [1, 2, 3, 4, 5]

# Convert types
['1', '2', '3'].map(&:to_i) # => [1, 2, 3]

# Transform strings
['hello', 'world'].map(&:upcase) # => ["HELLO", "WORLD"]

# Returns enumerator if no block
[1, 2, 3].map # => #<Enumerator: ...>
```

**Alias:** `collect`