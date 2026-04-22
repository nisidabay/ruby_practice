# first

Returns the first element or the first `n` elements from the array.

```ruby
arr = [1, 2, 3, 4, 5]

# Get first element
arr.first # => 1

# Get first n elements
arr.first(3) # => [1, 2, 3]

# Edge cases
[].first # => nil
[].first(2) # => []
```