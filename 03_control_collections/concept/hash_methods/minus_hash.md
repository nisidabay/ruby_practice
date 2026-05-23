# - (Minus / Difference)

Returns a new hash with specified keys removed. Ruby 2.6+.

```ruby
h = {a: 1, b: 2, c: 3, d: 4}

# Remove keys using array
h - [:a, :b] # => {:c=>3, :d=>4}
h - [:a] # => {:b=>2, :c=>3, :d=>4}

# Original unchanged
h # => {:a=>1, :b=>2, :c=>3, :d=>4}

# Missing keys ignored
h - [:x, :y] # => {:a=>1, :b=>2, :c=>3, :d=>4}

# Same as except with array
(h - [:a, :b]) == h.except(:a, :b) # => true

# String keys
h = {"a" => 1, "b" => 2}
h - ["a"] # => {"b"=>2}

# Mix of symbols/strings
h = {a: 1, "b" => 2}
h - [:a] # => {"b"=>2}
h - ["b"] # => {:a=>1}

# Remove sensitive fields
user = {name: "Alice", password: "secret", role: "admin"}
user - [:password] # => {:name=>"Alice", :role=>"admin"}
```

**Note:** Available in Ruby 2.6+. The operand must be an array of keys to remove.