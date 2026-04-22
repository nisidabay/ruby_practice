# concat

Concatenates arrays together (destructive, modifies the original array).

```ruby
arr = [1, 2, 3]

# Concatenate single array
arr.concat([4, 5]) # => [1, 2, 3, 4, 5]

# Concatenate multiple arrays
arr = [1]
arr.concat([2, 3], [4, 5]) # => [1, 2, 3, 4, 5]

# Original is modified
arr # => [1, 2, 3, 4, 5]
```