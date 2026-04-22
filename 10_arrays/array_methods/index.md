# index

Returns the index of the first matching element, or `nil` if not found.

```ruby
arr = ['a', 'b', 'c', 'b']

# Find index by value
arr.index('b') # => 1

# Find index with block
arr = [10, 20, 30, 40]
arr.index { |n| n > 25 } # => 2

# Not found
arr.index('z') # => nil
```

**Alias:** `find_index`