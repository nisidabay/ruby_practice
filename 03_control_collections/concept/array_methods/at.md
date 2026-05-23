# at

Returns the element at a given index, or `nil` if the index is out of bounds.

```ruby
arr = ['a', 'b', 'c', 'd']

# Positive index
arr.at(0) # => "a"
arr.at(2) # => "c"

# Negative index (from end)
arr.at(-1) # => "d"
arr.at(-2) # => "c"

# Out of bounds
arr.at(10) # => nil
```