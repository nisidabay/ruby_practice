# min

Returns the minimum element(s) from the array.

```ruby
arr = [3, 1, 4, 1, 5, 9, 2, 6]

# Single minimum
arr.min # => 1

# Multiple smallest
arr.min(3) # => [1, 1, 2]

# With block for custom comparison
['apple', 'pie', 'a'].min { |a, b| a.length <=> b.length } # => "a"

# Strings
['cherry', 'apple', 'banana'].min # => "apple"
```