# map!

Transforms elements in place, modifying self.

```ruby
arr = [1, 2, 3, 4, 5]

arr.map! { |n| n * 2 } # => [2, 4, 6, 8, 10]

# Original is modified
arr # => [2, 4, 6, 8, 10]

# Using symbol shortcut
words = ['hello', 'world']
words.map!(&:upcase)
words # => ["HELLO", "WORLD"]

# Returns self (modified)
result = arr.map! { |n| n }
result.equal?(arr) # => true
```

**Alias:** `collect!`