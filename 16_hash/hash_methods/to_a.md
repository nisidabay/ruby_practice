# to_a

Returns an array of key-value pairs as two-element arrays.

```ruby
h = {a: 1, b: 2, c: 3}

# Convert to array of pairs
h.to_a # => [[:a, 1], [:b, 2], [:c, 3]]

# Order preserved (Ruby 1.9+)
h = {d: 4, a: 1, c: 3}
h.to_a # => [[:d, 4], [:a, 1], [:c, 3]]

# Empty hash
{}.to_a # => []

# Useful for iteration patterns
h.to_a.each { |key, value| process(key, value) }

# Flatten further
h.to_a.flatten # => [:a, 1, :b, 2, :c, 3]

# Convert to other formats
h.to_a.map { |k, v| "#{k}=#{v}" } # => ["a=1", "b=2", "c=3"]
```