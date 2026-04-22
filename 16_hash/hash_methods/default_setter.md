# default=

Sets the default value for keys not found in the hash.

```ruby
h = {}

# Set default value
h.default = 0
h[:missing] # => 0

# Override existing default
h.default = "not found"
h[:x] # => "not found"

# Default only affects missing keys
h[:a] = 1
h.default = 99
h[:a] # => 1 (existing value)
h[:b] # => 99 (default for missing)

# Useful for counters
counts = {}
counts.default = 0
counts[:a] += 1 # Works! (0 + 1 = 1)
counts # => {:a=>1}
```

**Note:** Setting default replaces any existing default_proc.