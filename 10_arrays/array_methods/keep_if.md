# keep_if

Keeps elements for which the block returns `true`, deletes others (destructive).

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Keep only even numbers
arr.keep_if { |n| n.even? } # => [2, 4, 6, 8, 10]
arr # => [2, 4, 6, 8, 10]

# Keep strings longer than 3 characters
words = ['cat', 'dog', 'elephant', 'giraffe']
words.keep_if { |w| w.length > 3 } # => ["elephant", "giraffe"]

# Compare with select! (returns nil if unchanged)
arr = [1, 2, 3]
arr.keep_if { true } # => [1, 2, 3] (always returns self)
```