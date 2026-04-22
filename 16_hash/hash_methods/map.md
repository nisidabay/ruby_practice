# map

Returns a new hash with results of running the block on each key-value pair (actually returns an array for Hash).

```ruby
h = {a: 1, b: 2, c: 3}

# Transform to array of values
h.map { |k, v| v * 2 } # => [2, 4, 6]

# Transform to array of pairs
h.map { |k, v| [k.to_s, v] } # => [["a", 1], ["b", 2], ["c", 3]]

# Get array of keys/vals
h.map { |k, v| k } # => [:a, :b, :c]
h.map { |k, v| v } # => [1, 2, 3]

# Returns enumerator if no block
enum = h.map
enum.to_a # => [[:a, 1], [:b, 2], [:c, 3]]

# For transforming to Hash, use transform_values/transform_keys
h.transform_values { |v| v * 2 } # => {:a=>2, :b=>4, :c=>6}

# Using to_h for custom transformation
h.map { |k, v| [k.to_s, v * 2] }.to_h # => {"a"=>2, "b"=>4, "c"=>6}
```

**Note:** Hash#map returns an array, not a hash. Use `transform_values` or `transform_keys` to get a hash result.

**Alias:** `collect`