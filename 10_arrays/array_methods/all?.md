# all?

Returns `true` if all elements pass the given condition (block), or if all elements are truthy when no block given.

```ruby
# Check if all elements meet condition
[2, 4, 6, 8].all? { |n| n.even? } # => true
[2, 4, 5, 8].all? { |n| n.even? } # => false

# Without block, checks truthiness
[1, 'a', true].all? # => true
[1, nil, 3].all? # => false
```