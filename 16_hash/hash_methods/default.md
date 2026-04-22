# default

Returns the default value for keys not found in the hash.

```ruby
# Hash created without default
h = {a: 1, b: 2}
h.default # => nil

# Hash with default value
h = Hash.new(0)
h.default # => 0
h[:missing] # => 0

# Hash with default block
h = Hash.new { |hash, key| "missing: #{key}" }
h.default # => nil (block doesn't set default)
h[:x] # => "missing: :x"

# Setting default after creation
h = {}
h.default = "not found"
h[:missing] # => "not found"
h.default # => "not found"

# Default doesn't affect existing keys
h = {a: 1}
h.default = 0
h[:a] # => 1 (existing key)
h[:b] # => 0 (missing key)
```