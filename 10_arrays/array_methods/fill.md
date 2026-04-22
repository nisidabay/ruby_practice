# fill

Replaces elements with a specified value, optionally within a range (destructive).

```ruby
arr = [1, 2, 3, 4, 5]

# Fill entire array
arr.fill(0) # => [0, 0, 0, 0, 0]

# Fill specific range
arr = [1, 2, 3, 4, 5]
arr.fill(0, 2, 2) # => [1, 2, 0, 0, 5] (2 elements from index 2)

# Fill with range
arr = [1, 2, 3, 4, 5]
arr.fill(0, (1..3)) # => [1, 0, 0, 0, 5]

# Fill with block
arr = [1, 2, 3, 4, 5]
arr.fill { |i| i * 2 } # => [0, 2, 4, 6, 8]
```