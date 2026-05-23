# compact

Returns a new hash with all `nil` values removed. Ruby 2.4+.

```ruby
h = {a: 1, b: nil, c: 3, d: nil}

# Remove nil values
h.compact # => {:a=>1, :c=>3}

# Original unchanged
h # => {:a=>1, :b=>nil, :c=>3, :d=>nil}

# No nil values
{a: 1, b: 2}.compact # => {:a=>1, :b=>2}

# Empty hash
{}.compact # => {}

# Only removes nil (values, not keys)
{nil => "key is nil", a: nil}.compact
# => {nil=>"key is nil"} (key preserved, nil value removed)

# Useful for cleaning config
config = {name: "app", debug: nil, port: 3000, log: nil}
config.compact # => {:name=>"app", :port=>3000}
```

**Note:** Available in Ruby 2.4+