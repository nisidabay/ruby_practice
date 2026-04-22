# to_h

Returns self if called on a Hash. Also used for conversion by other types.

```ruby
h = {a: 1, b: 2}

# Returns self
h.to_h # => {:a=>1, :b=>2}
h.to_h.equal?(h) # => true (same object)

# Useful for explicit conversion in methods
def process(hash_like)
  hash_like.to_h.transform_keys(&:to_sym)
end

# On non-hash objects
a = [[:a, 1], [:b, 2]]
a.to_h # => {:a=>1, :b=>2}

# With block (Ruby 2.6+)
h = {a: 1, b: 2}
h.to_h { |k, v| [k.to_s, v * 2] } # => {"a"=>2, "b"=>4}
# Original unchanged
h # => {:a=>1, :b=>2}

# Filter and convert
{a: 1, b: 2, c: 3}.to_h { |k, v| [k, v] if v.even? } # => {:b=>2}
```