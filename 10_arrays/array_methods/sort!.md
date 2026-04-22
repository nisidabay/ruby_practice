# sort!

Sorts the array in place (destructive).

```ruby
arr = [3, 1, 4, 1, 5, 9, 2, 6]

# Default ascending sort
arr.sort! # => [1, 1, 2, 3, 4, 5, 6, 9]

# Original is modified
arr # => [1, 1, 2, 3, 4, 5, 6, 9]

# Sort descending
arr = [3, 1, 4, 1, 5]
arr.sort! { |a, b| b <=> a } # => [5, 4, 3, 1, 1]

# Sort strings
words = ['banana', 'apple', 'cherry']
words.sort! # => ["apple", "banana", "cherry"]
```