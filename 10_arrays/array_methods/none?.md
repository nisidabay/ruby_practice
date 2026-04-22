# none?

Returns `true` if no elements pass the given condition (block), or if all elements are falsy when no block given.

```ruby
# Check if no element meets condition
[1, 3, 5, 7].none? { |n| n.even? } # => true
[1, 2, 5, 7].none? { |n| n.even? } # => false

# Without block, checks if all are falsy
[nil, false].none? # => true
[nil, 1].none? # => false
```