# transform_values

Returns a new hash with each value transformed by the block. Keys remain unchanged.

```ruby
h = {a: 1, b: 2, c: 3}

# Transform values
h.transform_values { |v| v * 2 } # => {:a=>2, :b=>4, :c=>6}

# Transform values with method reference
h.transform_values(&:to_s) # => {:a=>"1", :b=>"2", :c=>"3"}

# Original unchanged
h # => {:a=>1, :b=>2, :c=>3}

# String transformation
h.transform_values { |v| "value: #{v}" }
# => {:a=>"value: 1", :b=>"value: 2", :c=>"value: 3"}

# Returns enumerator if no block
enum = h.transform_values

# Common patterns
{a: [1, 2], b: [3, 4]}.transform_values(&:sum) # => {:a=>3, :b=>7}
```

**Note:** Available in Ruby 2.4+