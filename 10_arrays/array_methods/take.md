# take

Returns the first `n` elements without modifying the original array.

```ruby
arr = [1, 2, 3, 4, 5]

arr.take(3) # => [1, 2, 3]

# Original is unchanged
arr # => [1, 2, 3, 4, 5]

# Taking more than length returns full array
arr.take(10) # => [1, 2, 3, 4, 5]
```