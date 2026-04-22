# keep_if

Destructively keeps entries for which the block returns `true`. Always returns self (even if no changes).

```ruby
h = {a: 1, b: 2, c: 3, d: 4}

# Keep only even values
h.keep_if { |k, v| v.even? }
h # => {:b=>2, :d=>4}

# Always returns self
h = {a: 1, b: 2, c: 3}
result = h.keep_if { |k, v| v.is_a?(Integer) }
result.equal?(h) # => true (always self)

# Compare with select!
h = {a: 1, b: 2}
h.keep_if { |k, v| v.is_a?(Integer) } # => {:a=>1, :b=>2} (self)
h.select! { |k, v| v.is_a?(Integer) } # => nil (no changes)

# Returns enumerator if no block
enum = h.keep_if
```

**Difference from `select!`:** `keep_if` always returns self, while `select!` returns nil if no changes.