# each_with_index

Iterates over key-value pairs with their index. Returns self.

```ruby
h = {a: 1, b: 2, c: 3}

# Iterate with index
h.each_with_index { |(k, v), i| puts "#{i}: #{k}=#{v}" }
# prints: 0: a=1, 1: b=2, 2: c=3

# Note the (k, v) parentheses to destructure the pair
h.each_with_index do |pair, i|
  puts "index #{i}: key=#{pair[0]}, value=#{pair[1]}"
end

# Returns self
result = h.each_with_index { |pair, i| pair }
result # => {:a=>1, :b=>2, :c=>3}

# Returns enumerator if no block
enum = h.each_with_index
enum.to_a # => [[[:a, 1], 0], [[:b, 2], 1], [[:c, 3], 2]]

# Build indexed lookup
lookup = {}
h.each_with_index { |(k, v), i| lookup[i] = k }
lookup # => {0=>:a, 1=>:b, 2=>:c}
```