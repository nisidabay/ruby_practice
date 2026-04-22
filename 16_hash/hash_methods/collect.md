# collect

Returns an array with results of running the block on each key-value pair. Identical to `map`.

```ruby
h = {a: 1, b: 2, c: 3}

# Collect values as array
h.collect { |k, v| v * 2 } # => [2, 4, 6]

# Collect pairs as array
h.collect { |k, v| [k, v * 2] } # => [[:a, 2], [:b, 4], [:c, 6]]

# Returns enumerator if no block
enum = h.collect
enum.to_a # => [[:a, 1], [:b, 2], [:c, 3]]

# Common use: collect all values
h.collect { |k, v| {key: k, val: v} }
# => [{:key=>:a, :val=>1}, {:key=>:b, :val=>2}, {:key=>:c, :val=>3}]
```

**Alias of:** `map`

**Note:** Use `transform_values` or `transform_keys` if you need a hash result.