# uniq

Returns a new array with duplicate elements removed, preserving original order.

```ruby
arr = [1, 2, 2, 3, 3, 3, 4]
arr.uniq # => [1, 2, 3, 4]

# Original is unchanged
arr # => [1, 2, 2, 3, 3, 3, 4]

# With block for custom uniqueness
users = [{ name: 'Alice' }, { name: 'Bob' }, { name: 'Alice' }]
users.uniq { |u| u[:name] } # => [{ name: 'Alice' }, { name: 'Bob' }]
```