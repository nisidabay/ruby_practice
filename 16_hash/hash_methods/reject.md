# reject

Returns a new hash excluding entries for which the block returns `true`.

```ruby
h = {a: 1, b: 2, c: 3, d: 4}

# Reject even values
h.reject { |k, v| v.even? } # => {:a=>1, :c=>3}

# Reject by key
h.reject { |k, v| k == :d } # => {:a=>1, :b=>2, :c=>3}

# Original unchanged
h # => {:a=>1, :b=>2, :c=>3, :d=>4}

# Returns enumerator if no block
enum = h.reject

# Remove nil values
config = {name: "Alice", age: nil, city: "NYC", phone: nil}
config.reject { |k, v| v.nil? } # => {:name=>"Alice", :city=>"NYC"}

# Opposite of select
h.select { |k, v| v.even? } # => {:b=>2, :d=>4}
h.reject { |k, v| v.even? } # => {:a=>1, :c=>3}
```