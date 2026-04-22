# compact!

Removes `nil` values from the array in place (destructive).

```ruby
arr = [1, nil, 2, nil, 3, nil]

arr.compact! # => [1, 2, 3]
arr # => [1, 2, 3]

# Returns nil if no changes made
arr = [1, 2, 3]
arr.compact! # => nil (no nils to remove)
arr # => [1, 2, 3]

# Compare with non-destructive version
arr2 = [1, nil, 2]
arr2.compact # => [1, 2] (new array)
arr2 # => [1, nil, 2] (unchanged)
```