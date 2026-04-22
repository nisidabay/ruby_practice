# filter

Returns a new array containing elements for which the block returns `true`.

```ruby
arr = [1, 2, 3, 4, 5, 6]

# Filter positive numbers
arr.filter { |n| n > 3 } # => [4, 5, 6]

# Filter strings by length
words = ['cat', 'elephant', 'dog', 'giraffe']
words.filter { |w| w.length <= 4 } # => ["cat", "dog"]

# Works identically to #select
```

**Alias:** `select`