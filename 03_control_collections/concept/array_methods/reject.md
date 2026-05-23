# reject

Returns a new array containing elements for which the block returns `false`.

```ruby
arr = [1, 2, 3, 4, 5, 6]

# Reject even numbers
arr.reject { |n| n.even? } # => [1, 3, 5]

# Reject with condition
words = ['apple', 'banana', 'kiwi', 'strawberry']
words.reject { |w| w.length > 5 } # => ["apple", "kiwi"]

# Original is unchanged
arr # => [1, 2, 3, 4, 5, 6]
```