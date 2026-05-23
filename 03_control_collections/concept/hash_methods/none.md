# none?

Returns `true` if no key-value pair satisfies the block, or if hash is empty (no block).

```ruby
h = {a: 1, b: 2, c: 3}

# Without block: true if empty or all falsy values
h.none? # => false (has truthy values)
{}.none? # => true (empty hash)
{a: nil}.none? # => true (only nil)
{a: false}.none? # => true (only false)

# With block: true if none match
h.none? { |k, v| v > 10 } # => true
h.none? { |k, v| v > 2 } # => false

# Check no negative values
{a: 1, b: 2, c: 3}.none? { |k, v| v < 0 } # => true

# Check no string keys
{a: 1, b: 2}.none? { |k, v| k.is_a?(String) } # => true

# Empty hash returns true with any block
{}.none? { |k, v| true } # => true

# Opposite of any?
h.any? { |k, v| v > 2 } # => true
h.none? { |k, v| v > 2 } # => false

# Common pattern: validation passes
errors = {}
errors.none? # => true (no errors)
```