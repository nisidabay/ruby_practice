# & (Intersection)

Returns a new array with elements common to both arrays (set intersection).

```ruby
a = [1, 2, 3, 4]
b = [3, 4, 5, 6]

a & b # => [3, 4]

# Preserves order from first array
[4, 3, 2, 1] & [1, 2, 5] # => [2, 1]

# Removes duplicates
[1, 1, 2, 2, 3] & [2, 3, 4] # => [2, 3]

# Originals are unchanged
a # => [1, 2, 3, 4]
```