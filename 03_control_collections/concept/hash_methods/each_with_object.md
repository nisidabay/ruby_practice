# each_with_object

Iterates over key-value pairs, passing both and a memo object to the block. Returns the memo object.

```ruby
h = {a: 1, b: 2, c: 3}

# Build a new hash
result = h.each_with_object({}) do |(k, v), memo|
  memo[k.to_s] = v * 2
end
result # => {"a"=>2, "b"=>4, "c"=>6}

# Sum values
sum = h.each_with_object(0) { |(k, v), total| total += v }
sum # => 6

# Collect matching entries
h = {a: 1, b: 2, c: 3, d: 4}
evens = h.each_with_object([]) { |(k, v), arr| arr << k if v.even? }
evens # => [:b, :d]

# Returns the memo object, not self
h.each_with_object([]) { |pair, arr| arr << pair } # => [[:a, 1], [:b, 2], [:c, 3]]

# Returns enumerator if no block
enum = h.each_with_object({})
```