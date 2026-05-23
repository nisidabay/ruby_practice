# count

Returns the count of elements, optionally filtered by a block or matching value.

```ruby
arr = [1, 2, 3, 4, 5, 3, 3]

# Count all elements
arr.count # => 7

# Count specific value
arr.count(3) # => 3

# Count with block
arr = [1, 2, 3, 4, 5]
arr.count { |x| x > 2 } # => 3
```