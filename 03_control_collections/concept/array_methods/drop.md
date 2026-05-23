# drop

Returns all elements except the first `n`, without modifying the original array.

```ruby
arr = [1, 2, 3, 4, 5]

arr.drop(2) # => [3, 4, 5]

# Original is unchanged
arr # => [1, 2, 3, 4, 5]

# Dropping more than length returns empty array
arr.drop(10) # => []
```