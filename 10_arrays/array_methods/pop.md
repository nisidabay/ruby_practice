# pop

Removes and returns the last element (or `n` elements) from the array (destructive).

```ruby
arr = [1, 2, 3, 4, 5]

# Remove single element
arr.pop # => 5
arr # => [1, 2, 3, 4]

# Remove multiple elements
arr = [1, 2, 3, 4, 5]
arr.pop(2) # => [4, 5]
arr # => [1, 2, 3]

# Empty array returns nil
[].pop # => nil
```