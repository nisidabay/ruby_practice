# transform_values!

Destructively transforms all values in place. Returns self.

```ruby
h = {a: 1, b: 2, c: 3}

# Transform values in place
h.transform_values! { |v| v * 2 }
h # => {:a=>2, :b=>4, :c=>6}

# Chain transformations
h = {a: 1, b: 2}
h.transform_values! { |v| v * 10 }
h.transform_values!(&:to_s)
h # => {:a=>"10", :b=>"20"}

# Returns self (modified hash)
result = h.transform_values!(&:upcase)
result.equal?(h) # => true

# Common pattern: process values
response = {id: "123", count: "456"}
response.transform_values!(&:to_i)
response # => {:id=>123, :count=>456}
```

**Note:** Available in Ruby 2.4+