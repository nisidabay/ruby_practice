# any?

Returns `true` if any element passes the given condition (block), or if any element is truthy when no block given.

```ruby
# Check if any element meets condition
[1, 3, 5, 7].any? { |n| n.even? } # => false
[1, 2, 5, 7].any? { |n| n.even? } # => true

# Without block, checks truthiness
[nil, false].any? # => false
[nil, 1].any? # => true
```