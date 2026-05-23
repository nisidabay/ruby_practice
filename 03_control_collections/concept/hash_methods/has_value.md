# has_value?

Returns `true` if the value exists in the hash, `false` otherwise.

```ruby
h = {a: 1, b: 2, c: 3}

# Value exists
h.has_value?(1) # => true
h.has_value?(2) # => true

# Value doesn't exist
h.has_value?(99) # => false

# Works with any value type
h = {name: "Alice", age: 30}
h.has_value?("Alice") # => true
h.has_value?(30) # => true

# Checks values, not keys
h.has_value?(:a) # => false (:a is a key, not a value)

# Useful for value validation
valid_status = {draft: "pending", published: "approved"}
if valid_status.has_value?(params[:status])
  save_post
end
```

**Alias:** `value?`