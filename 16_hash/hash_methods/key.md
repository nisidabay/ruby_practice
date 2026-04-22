# key

Returns the key for a given value, or `nil` if not found. Only returns first matching key.

```ruby
h = {a: 1, b: 2, c: 3}

# Find key by value
h.key(1) # => :a
h.key(2) # => :b

# Value not found
h.key(99) # => nil

# Only returns first key if multiple have same value
h = {a: 1, b: 1, c: 1}
h.key(1) # => :a (only first key returned)

# Works with any value type
h = {name: "Alice", age: 30}
h.key("Alice") # => :name

# Useful for reverse lookup
countries = {us: "United States", uk: "United Kingdom"}
countries.key("United States") # => :us
```

**Note:** Also see `keys` for getting all keys, and `invert` for swapping keys/values.