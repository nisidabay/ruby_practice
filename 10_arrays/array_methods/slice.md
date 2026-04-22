# slice

Returns a subset of elements from the array (non-destructive).

```ruby
arr = ['a', 'b', 'c', 'd', 'e']

# Slice from index
arr.slice(2) # => "c"
arr.slice(1, 3) # => ["b", "c", "d"]

# Slice with range
arr.slice(1..3) # => ["b", "c", "d"]
arr.slice(1...3) # => ["b", "c"]

# Negative indices
arr.slice(-3, 2) # => ["c", "d"]

# Out of bounds returns nil
arr.slice(10) # => nil
```