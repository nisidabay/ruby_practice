# detect

Returns the first element for which the block returns `true`, or `nil` if not found.

```ruby
arr = [5, 10, 15, 20, 25]

# Detect first multiple of 20
arr.detect { |n| n % 20 == 0 } # => 20

# Detect first string with 'x'
words = ['apple', 'box', 'extra', 'test']
words.detect { |w| w.include?('x') } # => "box"

# Works identically to #find
```

**Alias:** `find`