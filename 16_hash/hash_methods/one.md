# one?

Returns `true` if exactly one key-value pair satisfies the block, or if hash has exactly one entry (no block).

```ruby
h = {a: 1, b: 2, c: 3}

# Without block: true if exactly one entry
h.one? # => false (has 3 entries)
{a: 1}.one? # => true (exactly one)
{}.one? # => false (empty)
{a: 1, b: 2}.one? # => false (has 2 entries)

# With block: true if exactly one match
h.one? { |k, v| v > 2 } # => true (only :c=>3)
h.one? { |k, v| v > 1 } # => false (both :b and :c)

# Exactly one even number
{a: 1, b: 2, c: 3}.one? { |k, v| v.even? } # => true

# Exactly one string value
{a: 1, b: "x", c: 3}.one? { |k, v| v.is_a?(String) } # => true

# Check unique admin
roles = {alice: "admin", bob: "user", charlie: "user"}
roles.one? { |k, v| v == "admin" } # => true

# Empty hash always returns false
{}.one? { |k, v| true } # => false
```