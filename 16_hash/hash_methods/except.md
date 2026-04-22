# except

Returns a new hash excluding the specified keys. Ruby 3.0+.

```ruby
h = {a: 1, b: 2, c: 3, d: 4}

# Exclude specific keys
h.except(:a) # => {:b=>2, :c=>3, :d=>4}
h.except(:a, :b) # => {:c=>3, :d=>4}

# Missing keys ignored
h.except(:x, :y) # => {:a=>1, :b=>2, :c=>3, :d=>4}

# Original unchanged
h # => {:a=>1, :b=>2, :c=>3, :d=>4}

# Useful for removing sensitive data
user = {name: "Alice", password: "secret", token: "abc123", role: "admin"}
safe_user = user.except(:password, :token)
# => {:name=>"Alice", :role=>"admin"}

# Remove optional params
config = {debug: true, verbose: false, output: "file", format: "json"}
runtime = config.except(:debug, :verbose)
# => {:output=>"file", :format=>"json"}

# Combine with slice
h.except(:a, :b) # => {:c=>3, :d=>4}
h.slice(:c, :d) # => {:c=>3, :d=>4} (same result)
```

**Note:** Available in Ruby 3.0+. For earlier versions, use `h.reject { |k, _| [:a, :b].include?(k) }`.