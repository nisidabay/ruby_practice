# difference

Returns a new array with elements that are in the receiver but not in any of the argument arrays (Ruby 2.6+).

```ruby
[1, 2, 3, 4, 5].difference([2, 4]) # => [1, 3, 5]

# Multiple arguments
[1, 2, 3, 4, 5, 6].difference([2], [4, 6]) # => [1, 3, 5]

# Preserves order and duplicates
[1, 1, 2, 2, 3].difference([2]) # => [1, 1, 3]

# Original is unchanged
arr = [1, 2, 3]
arr.difference([2]) # => [1, 3]
arr # => [1, 2, 3]
```