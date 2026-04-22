# fetch

Returns the value for a given key. Raises `KeyError` if key not found (unlike `[]` which returns nil).

```ruby
h = {a: 1, b: 2, c: 3}

# Basic fetch
h.fetch(:a) # => 1
h.fetch(:b) # => 2

# Key not found raises KeyError
h.fetch(:z) # KeyError: key not found: :z

# With default value (second argument)
h.fetch(:z, 0) # => 0
h.fetch(:missing, "default") # => "default"

# With block
h.fetch(:z) { |key| "#{key} not found" } # => "z not found"

# Useful for required configuration
config = {host: "localhost", port: 3000}
host = config.fetch(:host) # Required, will raise if missing
port = config.fetch(:port, 8080) # Optional with default

# Default value is NOT evaluated if key exists
h.fetch(:a, expensive_operation) # won't call expensive_operation
```