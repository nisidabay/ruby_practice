# slice!

Removes and returns the specified slice from the array (destructive).

```ruby
arr = ['a', 'b', 'c', 'd', 'e']

# Remove and return element at index
arr.slice!(2) # => "c"
arr # => ["a", "b", "d", "e"]

# Remove and return range
arr = ['a', 'b', 'c', 'd', 'e']
arr.slice!(1..3) # => ["b", "c", "d"]
arr # => ["a", "e"]

# Remove n elements starting at index
arr = ['a', 'b', 'c', 'd', 'e']
arr.slice!(1, 2) # => ["b", "c"]
arr # => ["a", "d", "e"]
```