# uniq!

Removes duplicate elements from the array in place (destructive).

```ruby
arr = [1, 2, 2, 3, 3, 3, 4]

arr.uniq! # => [1, 2, 3, 4]
arr # => [1, 2, 3, 4]

# Returns nil if no changes made
arr = [1, 2, 3]
arr.uniq! # => nil (already unique)
arr # => [1, 2, 3]

# With block for custom uniqueness
users = [{ name: 'Alice' }, { name: 'Bob' }, { name: 'Alice' }]
users.uniq! { |u| u[:name] }
users # => [{ name: 'Alice' }, { name: 'Bob' }]
```