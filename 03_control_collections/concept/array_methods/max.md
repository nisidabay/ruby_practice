# max

Returns the maximum element(s) from the array.

```ruby
arr = [3, 1, 4, 1, 5, 9, 2, 6]

# Single maximum
arr.max # => 9

# Multiple largest
arr.max(3) # => [9, 6, 5]

# With block for custom comparison
['apple', 'pie', 'strawberry'].max { |a, b| a.length <=> b.length } # => "strawberry"

# Strings
['cherry', 'apple', 'banana'].max # => "cherry"
```