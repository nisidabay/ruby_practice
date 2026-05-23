# select

Returns a new array containing elements for which the block returns `true`.

```ruby
arr = [1, 2, 3, 4, 5, 6]

# Select even numbers
arr.select { |n| n.even? } # => [2, 4, 6]

# Select with condition
words = ['apple', 'banana', 'kiwi', 'strawberry']
words.select { |w| w.length > 5 } # => ["banana", "strawberry"]

# Original is unchanged
arr # => [1, 2, 3, 4, 5, 6]
```

**Alias:** `filter`