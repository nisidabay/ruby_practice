# any?

Returns `true` if any key-value pair satisfies the block, or if hash is non-empty (no block).

```ruby
h = {a: 1, b: 2, c: 3}

# Without block: true if non-empty
h.any? # => true
{}.any? # => false

# With block: true if any match
h.any? { |k, v| v > 2 } # => true
h.any? { |k, v| v > 10 } # => false

# Check if any value matches
h.any? { |k, v| v.even? } # => true

# Check if any key matches
h.any? { |k, v| k == :b } # => true

# Empty hash with block
{}.any? { |k, v| true } # => false

# Early exit: stops at first true
h.any? { |k, v| puts k; v > 1 } # prints: a, stops and returns true

# Useful for validation
errors = {name: "too short", email: "invalid"}
errors.any? { |k, v| v } # => true (has errors)
```