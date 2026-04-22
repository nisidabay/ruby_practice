# fetch_values

Returns an array of values for the given keys. Raises `KeyError` if any key is not found.

```ruby
h = {a: 1, b: 2, c: 3}

# Fetch multiple values
h.fetch_values(:a, :b, :c) # => [1, 2, 3]

# Order preserved
h.fetch_values(:c, :a) # => [3, 1]

# Missing key raises KeyError
h.fetch_values(:a, :z) # KeyError: key not found: :z

# With default block
h.fetch_values(:a, :z) { |key| 0 } # => [1, 0]

# Useful for extracting required keys
params = {name: "Alice", email: "alice@example.com"}
name, email = params.fetch_values(:name, :email)

# Compare with values_at (returns nil for missing)
h.values_at(:a, :z) # => [1, nil]
h.fetch_values(:a, :z) # KeyError
```