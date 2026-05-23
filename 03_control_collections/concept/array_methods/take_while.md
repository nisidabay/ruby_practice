# take_while

Takes elements from the beginning while the block returns `true`.

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8]

# Take while condition is true
arr.take_while { |n| n < 4 } # => [1, 2, 3]

# Stops at first false
arr = [2, 4, 6, 7, 8]
arr.take_while { |n| n.even? } # => [2, 4, 6]
```