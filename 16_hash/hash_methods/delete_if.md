# delete_if

Destructively deletes entries for which the block returns `true`. Always returns self.

```ruby
h = {a: 1, b: 2, c: 3, d: 4}

# Delete even values
h.delete_if { |k, v| v.even? }
h # => {:a=>1, :c=>3}

# Always returns self
h = {a: 1, b: 2, c: 3}
result = h.delete_if { |k, v| v > 10 }
result.equal?(h) # => true (always self, even with no changes)

# Compare with reject!
h = {a: 1, b: 2}
h.delete_if { |k, v| v > 10 } # => {:a=>1, :b=>2} (self)
h.reject! { |k, v| v > 10 } # => nil (no changes)

# Returns enumerator if no block
enum = h.delete_if

# Delete by key pattern
h = {name: "Alice", pass: "secret", token: "abc"}
h.delete_if { |k, v| k == :pass || k == :token }
# => {:name=>"Alice"}
```

**Difference from `reject!`:** `delete_if` always returns self, while `reject!` returns nil if no changes.