# delete_if

Deletes elements for which the block returns `true` (destructive).

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Delete all even numbers
arr.delete_if { |n| n.even? } # => [1, 3, 5, 7, 9]
arr # => [1, 3, 5, 7, 9]

# Delete strings containing 'a'
words = ['apple', 'banana', 'cherry', 'date']
words.delete_if { |w| w.include?('a') } # => ["cherry"]

# Returns self (the modified array)
arr = [1, 2, 3]
result = arr.delete_if { false }
result.equal?(arr) # => true (same object)
```