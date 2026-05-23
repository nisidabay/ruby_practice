# delete

Deletes all elements equal to the given value (destructive).

```ruby
arr = [1, 2, 3, 2, 4, 2, 5]

# Delete all occurrences
arr.delete(2) # => 2
arr # => [1, 3, 4, 5]

# Returns nil if not found
arr = [1, 2, 3]
arr.delete(10) # => nil

# With block for missing value
arr.delete(10) { "not found" } # => "not found"
```