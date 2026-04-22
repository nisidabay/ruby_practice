# == (Equality)

Returns `true` if two hashes have the same content (keys and values), `false` otherwise.

```ruby
# Same content
{a: 1} == {a: 1} # => true
{a: 1, b: 2} == {a: 1, b: 2} # => true

# Order doesn't matter
{a: 1, b: 2} == {b: 2, a: 1} # => true

# Different keys
{a: 1} == {b: 1} # => false

# Different values
{a: 1} == {a: 2} # => false

# Different sizes
{a: 1} == {a: 1, b: 2} # => false

# Compared with non-hash
{a: 1} == "not a hash" # => false

# Nested hashes
{user: {name: "Alice"}} == {user: {name: "Alice"}} # => true

# Comparison uses == for values
{a: 1} == {a: 1.0} # => true (1 == 1.0)
```