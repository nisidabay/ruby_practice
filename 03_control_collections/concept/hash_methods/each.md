# each

Iterates over key-value pairs, yielding each pair to the block. Returns self.

```ruby
h = {a: 1, b: 2, c: 3}

# Iterate with two block params
h.each { |key, value| puts "#{key}: #{value}" }
# prints: a: 1, b: 2, c: 3

# Iterate with single param (array pair)
h.each { |pair| puts "#{pair[0]} => #{pair[1]}" }

# Returns self
result = h.each { |k, v| v }
result # => {:a=>1, :b=>2, :c=>3}

# Returns enumerator if no block
enum = h.each # => #<Enumerator: ...>
enum.to_a # => [[:a, 1], [:b, 2], [:c, 3]]

# Chain with with_index
h.each.with_index { |(k, v), i| puts "#{i}: #{k}=#{v}" }
```