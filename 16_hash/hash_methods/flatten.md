# flatten

Returns a flattened array of keys and values (one level by default).

```ruby
h = {a: 1, b: 2, c: 3}

# Flatten to array
h.flatten # => [:a, 1, :b, 2, :c, 3]

# With level argument
h.flatten(1) # => [:a, 1, :b, 2, :c, 3] (same as default)

# Nested hash
h = {a: {x: 1}, b: {y: 2}}
h.flatten # => [:a, {:x=>1}, :b, {:y=>2}]
h.flatten(2) # => [:a, :x, 1, :b, :y, 2]

# No arguments = level 1
{a: 1}.flatten # => [:a, 1]

# Compare with to_a
h.to_a # => [[:a, 1], [:b, 2], [:c, 3]]
h.flatten # => [:a, 1, :b, 2, :c, 3]

# Useful for serialization
h.flatten.join(",") # => "a,1,b,2,c,3"
```