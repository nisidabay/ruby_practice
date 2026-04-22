# last

Returns the last element or the last `n` elements from the array.

```ruby
arr = [1, 2, 3, 4, 5]

# Get last element
arr.last # => 5

# Get last n elements
arr.last(3) # => [3, 4, 5]

# Edge cases
[].last # => nil
[].last(2) # => []
```