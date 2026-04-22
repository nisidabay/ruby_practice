# - (Minus)

Returns a new array with elements removed (difference, non-destructive).

```ruby
a = [1, 2, 3, 4, 5]
b = [2, 4]

a - b # => [1, 3, 5]

# Removes ALL occurrences
[1, 2, 2, 3, 2] - [2] # => [1, 3]

# Originals are unchanged
a # => [1, 2, 3, 4, 5]

# Order from first array is preserved
[5, 4, 3, 2, 1] - [1, 5] # => [4, 3, 2]
```