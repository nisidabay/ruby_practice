# clear

Removes all elements from the array (destructive).

```ruby
arr = [1, 2, 3, 4, 5]

arr.clear # => []

# Original is modified
arr # => []
arr.empty? # => true

# Returns self (same object)
arr = [1, 2, 3]
arr.clear.equal?(arr) # => true
```