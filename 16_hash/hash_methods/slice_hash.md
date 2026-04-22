# slice

Returns a new hash with only the specified keys. Ruby 2.5+.

```ruby
h = {a: 1, b: 2, c: 3, d: 4}

# Extract specific keys
h.slice(:a, :b) # => {:a=>1, :b=>2}
h.slice(:a, :c) # => {:a=>1, :c=>3}

# Missing keys omitted
h.slice(:a, :x, :y) # => {:a=>1} (only :a exists)

# Original unchanged
h # => {:a=>1, :b=>2, :c=>3, :d=>4}

# Useful for extracting params
params = {name: "Alice", age: 30, email: "alice@example.com", password: "secret"}
user_params = params.slice(:name, :age, :email)
# => {:name=>"Alice", :age=>30, :email=>"alice@example.com"}

# With string keys
h = {"a" => 1, "b" => 2}
h.slice("a") # => {"a"=>1}

# Empty result if no keys match
h.slice(:x, :y) # => {}

# Multiple calls
h.slice(:a).slice(:a) # => {:a=>1}
```

**Note:** Available in Ruby 2.5+