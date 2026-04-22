# transform_keys

Returns a new hash with each key transformed by the block. Values remain unchanged.

```ruby
h = {a: 1, b: 2, c: 3}

# Transform keys to strings
h.transform_keys(&:to_s) # => {"a"=>1, "b"=>2, "c"=>3}

# Transform keys with custom logic
h.transform_keys { |k| k.to_s.upcase } # => {"A"=>1, "B"=>2, "C"=>3}

# Original unchanged
h # => {:a=>1, :b=>2, :c=>3}

# With symbolize_keys pattern
{"name" => "Alice", "age" => 30}.transform_keys(&:to_sym)
# => {:name=>"Alice", :age=>30}

# Returns enumerator if no block
enum = h.transform_keys
```

**Note:** Available in Ruby 2.5+