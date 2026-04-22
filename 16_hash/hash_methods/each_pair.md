# each_pair

Iterates over key-value pairs, yielding each pair to the block. Identical to `each`.

```ruby
h = {a: 1, b: 2, c: 3}

# Iterate with two block params
h.each_pair { |key, value| puts "#{key}: #{value}" }
# prints: a: 1, b: 2, c: 3

# Iterate with single param (array of pair)
h.each_pair { |pair| puts pair.inspect }
# prints: [:a, 1], [:b, 2], [:c, 3]

# Returns self
result = h.each_pair { |k, v| v }
result # => {:a=>1, :b=>2, :c=>3}

# Returns enumerator if no block
enum = h.each_pair
enum.to_a # => [[:a, 1], [:b, 2], [:c, 3]]

# Identical to each
h.each { |k, v| puts v } == h.each_pair { |k, v| puts v } # Same behavior
```

**Alias:** `each`