# select

Returns a new hash containing entries for which the block returns `true`.

```ruby
h = {a: 1, b: 2, c: 3, d: 4}

# Select even values
h.select { |k, v| v.even? } # => {:b=>2, :d=>4}

# Select by key
h.select { |k, v| k == :a || k == :b } # => {:a=>1, :b=>2}

# Original unchanged
h # => {:a=>1, :b=>2, :c=>3, :d=>4}

# Returns enumerator if no block
enum = h.select
enum.to_a # => [[:a, 1], [:b, 2], [:c, 3], [:d, 4]]

# Filter by key pattern
user = {name: "Alice", age: 30, city: "NYC", password: "secret"}
user.select { |k, v| [:name, :age].include?(k) }
# => {:name=>"Alice", :age=>30}
```

**Alias:** `filter`