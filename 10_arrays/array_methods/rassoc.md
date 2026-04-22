# rassoc

Searches for an element that is an array and whose second element equals the given value.

```ruby
arr = [['a', 1], ['b', 2], ['c', 3]]

# Find by second element
arr.rassoc(2) # => ["b", 2]

# Returns nil if not found
arr.rassoc(10) # => nil

# Works with any values
arr = [['name', 'Alice'], ['age', 30]]
arr.rassoc('Alice') # => ["name", "Alice"]

# Only checks second element of nested arrays
arr = [[1, 'a'], [2, 'b'], [3, 'c']]
arr.rassoc('b') # => [2, "b"]

# Compare with assoc (which checks first element)
```