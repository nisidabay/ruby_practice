# delete_at

Deletes the element at a given index and returns it (destructive).

```ruby
arr = ['a', 'b', 'c', 'd', 'e']

# Delete at index
arr.delete_at(2) # => "c"
arr # => ["a", "b", "d", "e"]

# Negative index
arr = ['a', 'b', 'c', 'd']
arr.delete_at(-1) # => "d"
arr # => ["a", "b", "c"]

# Returns nil if index out of bounds
arr = [1, 2, 3]
arr.delete_at(10) # => nil
```