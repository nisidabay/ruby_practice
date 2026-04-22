# select!

Keeps elements for which the block returns `true`, deleting others (destructive).

```ruby
arr = [1, 2, 3, 4, 5, 6]

# Keep only even numbers
arr.select! { |n| n.even? } # => [2, 4, 6]
arr # => [2, 4, 6]

# Returns nil if no changes made
arr = [2, 4, 6]
arr.select! { |n| n.even? } # => nil (already filtered)
arr # => [2, 4, 6]

# Compare with keep_if (keep_if always returns self)
```

**Alias:** `filter!`