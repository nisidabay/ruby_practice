# to_s

Returns a string representation of the hash.

```ruby
h = {a: 1, b: 2}

# String representation
h.to_s # => "{:a=>1, :b=>2}"

# Same as inspect
h.inspect # => "{:a=>1, :b=>2}"

# Different from joining
h.map { |k, v| "#{k}=#{v}" }.join(", ") # => "a=1, b=2"

# With string keys
{"name" => "Alice"}.to_s # => "{\"name\"=>\"Alice\"}"

# Nested hashes
{user: {name: "Alice"}}.to_s
# => "{:user=>{:name=>\"Alice\"}}"

# Useful for debugging
puts "Config: #{config.to_s}"
```