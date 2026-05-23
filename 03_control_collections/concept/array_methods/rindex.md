# rindex

Returns the index of the last matching element (searches from the end), or `nil` if not found.

```ruby
arr = ['a', 'b', 'c', 'b', 'd']

# Find last occurrence from end
arr.rindex('b') # => 3

# With block
arr = [10, 20, 30, 40, 50]
arr.rindex { |n| n < 30 } # => 1 (last element < 30)

# Not found
arr.rindex('z') # => nil
```