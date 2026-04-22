# sort

Returns a new array with elements sorted in ascending order.

```ruby
arr = [3, 1, 4, 1, 5, 9, 2, 6]

# Default sort (ascending)
arr.sort # => [1, 1, 2, 3, 4, 5, 6, 9]

# Sort with block for custom comparison
arr.sort { |a, b| b <=> a } # => [9, 6, 5, 4, 3, 2, 1, 1] (descending)

# String sorting
['banana', 'apple', 'cherry'].sort # => ["apple", "banana", "cherry"]

# Original is unchanged
arr # => [3, 1, 4, 1, 5, 9, 2, 6]
```