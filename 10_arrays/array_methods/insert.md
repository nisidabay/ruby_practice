# insert

Inserts elements at a given position, shifting existing elements right (destructive).

```ruby
arr = ['a', 'b', 'd', 'e']

# Insert at position
arr.insert(2, 'c') # => ["a", "b", "c", "d", "e"]

# Insert multiple elements
arr = [1, 2, 5]
arr.insert(2, 3, 4) # => [1, 2, 3, 4, 5]

# Negative index (counts from end)
arr = ['a', 'b', 'c']
arr.insert(-1, 'd') # => ["a", "b", "c", "d"]
```