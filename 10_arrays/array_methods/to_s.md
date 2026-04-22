# to_s

Returns a string representation of the array.

```ruby
arr = [1, 2, 3]

arr.to_s # => "[1, 2, 3]"

# Strings are quoted
arr = ['a', 'b', 'c']
arr.to_s # => "[\"a\", \"b\", \"c\"]"

# Empty array
[].to_s # => "[]"

# Nested arrays
[[1, 2], [3, 4]].to_s # => "[[1, 2], [3, 4]]"
```

**Alias:** `inspect` for array strings