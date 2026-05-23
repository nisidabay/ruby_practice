# transform_keys!

Destructively transforms all keys in place. Returns self.

```ruby
h = {a: 1, b: 2, c: 3}

# Transform keys in place
h.transform_keys!(&:to_s)
h # => {"a"=>1, "b"=>2, "c"=>3}

# Chain transformations
h = {a: 1, b: 2}
h.transform_keys! { |k| k.to_s.upcase }
h # => {"A"=>1, "B"=>2}

# Returns self (modified hash)
result = h.transform_keys!(&:downcase)
result.equal?(h) # => true

# Common pattern: stringify keys
params = {name: "Alice", age: 30}
params.transform_keys!(&:to_s)
params # => {"name"=>"Alice", "age"=>30}
```

**Note:** Available in Ruby 2.5+