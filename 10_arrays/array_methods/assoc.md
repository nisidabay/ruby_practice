# assoc

Searches for an element that is an array and whose first element equals the given value.

```ruby
arr = [['a', 1], ['b', 2], ['c', 3]]

# Find by first element
arr.assoc('b') # => ["b", 2]

# Returns nil if not found
arr.assoc('z') # => nil

# Works with any values
arr = [[1, 'one'], [2, 'two'], [3, 'three']]
arr.assoc(2) # => [2, "two"]

# Only checks first element of nested arrays
arr = [['apple', 'fruit'], ['carrot', 'vegetable']]
arr.assoc('apple') # => ["apple", "fruit"]
```