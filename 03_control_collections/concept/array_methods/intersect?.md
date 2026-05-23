# intersect?

Returns `true` if the array and another array have at least one element in common (Ruby 3.1+).

```ruby
[1, 2, 3].intersect?([3, 4, 5]) # => true (3 is common)
[1, 2, 3].intersect?([4, 5, 6]) # => false (no common elements)

# Works with any arrays
['a', 'b'].intersect?(['b', 'c']) # => true

# Empty arrays
[].intersect?([1, 2]) # => false
[].intersect?([]) # => false

# More efficient than (arr1 & arr2).any? for checking overlap
# Stops at first common element found
```