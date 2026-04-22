# one?

Returns `true` if exactly one element passes the given condition (block), or if exactly one element is truthy when no block given.

```ruby
# Check if exactly one element meets condition
[1, 2, 5, 7].one? { |n| n.even? } # => true
[2, 4, 6, 8].one? { |n| n.even? } # => false (more than one)

# Without block, checks if exactly one is truthy
[nil, 1, false].one? # => true
[nil, false].one? # => false
[1, 2, nil].one? # => false (two truthy)
```