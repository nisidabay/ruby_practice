# select!

Destructively removes all entries for which the block returns `false` or `nil`. Returns self if changes made, `nil` otherwise.

```ruby
h = {a: 1, b: 2, c: 3, d: 4}

# Keep only even values
h.select! { |k, v| v.even? }
h # => {:b=>2, :d=>4}

# Returns self if changes made
h = {a: 1, b: 2}
result = h.select! { |k, v| v.even? }
result # => {:b=>2}
result.equal?(h) # => true

# Returns nil if no changes
h = {a: 1, b: 2}
h.select! { |k, v| v.is_a?(Integer) } # => nil (no changes)
h # => {:a=>1, :b=>2}

# Returns enumerator if no block
enum = h.select!
```

**Alias:** `filter!`