# map!

Destructively transforms the hash by running the block on each key-value pair. Note: Hash doesn't have map!, use transform_keys! or transform_values! instead.

```ruby
# Hash does NOT have map! - this would be an error
h = {a: 1, b: 2}
h.map! { |k, v| v * 2 } # NoMethodError: undefined method `map!'

# Use transform_values! for in-place value transformation
h = {a: 1, b: 2, c: 3}
h.transform_values! { |v| v * 2 }
h # => {:a=>2, :b=>4, :c=>6}

# Use transform_keys! for in-place key transformation
h = {"a" => 1, "b" => 2}
h.transform_keys!(&:to_sym)
h # => {:a=>1, :b=>2}
```

**Note:** Hash does not have `map!`. Use `transform_values!` or `transform_keys!` instead.