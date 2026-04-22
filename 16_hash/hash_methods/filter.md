# filter

Returns a new hash containing entries for which the block returns `true`. Identical to `select`.

```ruby
h = {a: 1, b: 2, c: 3, d: 4}

# Filter even values
h.filter { |k, v| v.even? } # => {:b=>2, :d=>4}

# Filter by key
h.filter { |k, v| k.to_s.include?("a") } # => {:a=>1}

# Original unchanged
h # => {:a=>1, :b=>2, :c=>3, :d=>4}

# Returns enumerator if no block
enum = h.filter

# Filter nested hashes
data = {user: {name: "Alice", active: true}, guest: {name: "Bob", active: false}}
data.filter { |k, v| v[:active] } # => {:user=>{...}}
```

**Alias of:** `select`