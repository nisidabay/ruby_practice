# == (Equality)

Compares two arrays for equality, checking that they have the same length and corresponding elements are equal.

```ruby
# Arrays with same elements
[1, 2, 3] == [1, 2, 3] # => true

# Different order
[1, 2, 3] == [3, 2, 1] # => false

# Different types, same values
[1, 2, 3] == [1.0, 2.0, 3.0] # => true (uses == for comparison)

# Comparing with non-array
[1, 2] == 'not an array' # => false
```