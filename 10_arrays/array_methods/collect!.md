# collect!

Transforms elements in place, modifying self.

```ruby
arr = [1, 2, 3, 4, 5]

arr.collect! { |n| n ** 2 } # => [1, 4, 9, 16, 25]

# Original is modified
arr # => [1, 4, 9, 16, 25]

# Works identically to #map!
numbers = [1, 2, 3]
numbers.collect! { |n| n + 10 }
numbers # => [11, 12, 13]

# Returns self if changes made
result = arr.collect! { |n| n }
result.equal?(arr) # => true
```

**Alias:** `map!`