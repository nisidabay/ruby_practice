# sum

Returns the sum of all elements (using `+` operator).

```ruby
arr = [1, 2, 3, 4, 5]

arr.sum # => 15

# With initial value
arr.sum(10) # => 25 (10 + 15)

# Strings (requires initial value)
['a', 'b', 'c'].sum('') # => "abc"

# With block to transform
[1, 2, 3].sum { |n| n * 2 } # => 12 (2 + 4 + 6)

# Empty array returns initial (default 0)
[].sum # => 0
[].sum(100) # => 100

# Arrays of arrays (concatenates)
[[1, 2], [3, 4]].sum # => [1, 2, 3, 4]
```