# reverse!

Reverses the array in place (destructive).

```ruby
arr = [1, 2, 3, 4, 5]

arr.reverse! # => [5, 4, 3, 2, 1]

# Original is modified
arr # => [5, 4, 3, 2, 1]

# Compare with non-destructive version
arr2 = [1, 2, 3]
arr2.reverse # => [3, 2, 1] (new array)
arr2 # => [1, 2, 3] (unchanged)
```