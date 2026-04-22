# shift

Removes and returns the first element (or `n` elements) from the array (destructive).

```ruby
arr = [1, 2, 3, 4, 5]

# Remove single element
arr.shift # => 1
arr # => [2, 3, 4, 5]

# Remove multiple elements
arr = [1, 2, 3, 4, 5]
arr.shift(2) # => [1, 2]
arr # => [3, 4, 5]

# Empty array returns nil
[].shift # => nil
```