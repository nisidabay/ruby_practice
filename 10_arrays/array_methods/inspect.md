# inspect

Returns a string representation of the array (same as `to_s` for debugging).

```ruby
arr = [1, 2, 3]

arr.inspect # => "[1, 2, 3]"

# Strings include quotes
['a', 'b'].inspect # => "[\"a\", \"b\"]"

# Useful for debugging
arr = [1, nil, 'string', :symbol]
puts arr.inspect # => [1, nil, "string", :symbol]

# Nested structures
[{ a: 1 }, [2, 3]].inspect # => "[{:a=>1}, [2, 3]]"
```