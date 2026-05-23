# has_key?

Returns `true` if the key exists in the hash, `false` otherwise.

```ruby
h = {a: 1, b: 2, c: 3}

# Key exists
h.has_key?(:a) # => true
h.has_key?(:b) # => true

# Key doesn't exist
h.has_key?(:z) # => false

# Works with nil values
h = {a: nil}
h.has_key?(:a) # => true (key exists even though value is nil)
h[:a] # => nil

# Useful for checking key presence
if h.has_key?(:config)
  process_config(h[:config])
end
```

**Aliases:** `key?`, `include?`, `member?`