# find

Returns the first element for which the block returns `true`, or `nil` if not found.

```ruby
arr = [1, 2, 3, 4, 5]

# Find first even number
arr.find { |n| n.even? } # => 2

# Find with condition
words = ['apple', 'banana', 'cherry']
words.find { |w| w.start_with?('b') } # => "banana"

# Not found returns nil
arr.find { |n| n > 100 } # => nil
```

**Alias:** `detect`