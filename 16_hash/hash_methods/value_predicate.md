# value?

Returns `true` if the value exists in the hash, `false` otherwise.

```ruby
h = {a: 1, b: 2, c: 3}

# Value exists
h.value?(1) # => true
h.value?(2) # => true

# Value doesn't exist
h.value?(99) # => false

# Works with different value types
roles = {alice: "admin", bob: "user", charlie: "user"}
h.value?("admin") # => true
h.value?("guest") # => false

# Case-sensitive
h = {name: "Alice"}
h.value?("alice") # => false (case matters)
h.value?("Alice") # => true
```

**Alias of:** `has_value?`