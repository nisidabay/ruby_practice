# drop_while

Drops elements from the beginning while the block returns `true`, then returns the rest.

```ruby
arr = [1, 2, 3, 4, 5, 6]

# Drop while condition is true
arr.drop_while { |n| n < 4 } # => [4, 5, 6]

# Stops at first false
arr = [2, 4, 6, 7, 8]
arr.drop_while { |n| n.even? } # => [7, 8]
```