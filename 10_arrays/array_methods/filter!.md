# filter!

Keeps elements for which the block returns `true`, deleting others (destructive).

```ruby
arr = [1, 2, 3, 4, 5, 6]

# Keep only odd numbers
arr.filter! { |n| n.odd? } # => [1, 3, 5]
arr # => [1, 3, 5]

# Returns nil if no changes needed
arr = [1, 3, 5]
arr.filter! { |n| n.odd? } # => nil
arr # => [1, 3, 5]
```

**Alias:** `select!`