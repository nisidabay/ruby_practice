# key?

Returns `true` if the key exists in the hash, `false` otherwise.

```ruby
h = {a: 1, b: 2, c: 3}

# Key exists
h.key?(:a) # => true
h.key?(:b) # => true

# Key doesn't exist
h.key?(:z) # => false

# String vs symbol keys matter
h = {"name" => "Alice"}
h.key?("name") # => true
h.key?(:name) # => false

# Check existence before access
h = {a: 1}
h.key?(:b) ? h[:b] : "default" # => "default"
```

**Alias of:** `has_key?`

**Also aliased by:** `include?`, `member?`