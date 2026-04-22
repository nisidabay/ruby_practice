# all?

Returns `true` if all key-value pairs satisfy the block, or if hash is empty (no block).

```ruby
h = {a: 1, b: 2, c: 3}

# Without block: true if empty or all truthy
h.all? # => true (all values are truthy)
{a: 1, b: nil}.all? # => false (has nil)
{}.all? # => true (empty hash)

# With block: true if all match
h.all? { |k, v| v.is_a?(Integer) } # => true
h.all? { |k, v| v > 0 } # => true
h.all? { |k, v| v > 1 } # => false (1 is not > 1)

# Check all values
{a: "x", b: "y"}.all? { |k, v| v.is_a?(String) } # => true

# Check all keys
h.all? { |k, v| k.is_a?(Symbol) } # => true

# Empty hash with block returns true
{}.all? { |k, v| false } # => true (vacuous truth)

# All values are even
{a: 2, b: 4, c: 6}.all? { |k, v| v.even? } # => true
```