# reject!

Removes elements for which the block returns `true` (destructive).

```ruby
arr = [1, 2, 3, 4, 5, 6]

# Reject even numbers
arr.reject! { |n| n.even? } # => [1, 3, 5]
arr # => [1, 3, 5]

# Returns nil if no changes made
arr = [1, 3, 5]
arr.reject! { |n| n.even? } # => nil (nothing rejected)
arr # => [1, 3, 5]

# Compare with delete_if (always returns self)
arr = [1, 2, 3]
arr.delete_if { |n| n > 10 } # => [1, 2, 3] (returns self, not nil)
```