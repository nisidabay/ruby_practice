# include?

Returns `true` if the key exists in the hash, `false` otherwise.

```ruby
h = {a: 1, b: 2, c: 3}

# Key exists
h.include?(:a) # => true
h.include?(:b) # => true

# Key doesn't exist
h.include?(:z) # => false

# Works with nil values
h = {a: nil}
h.include?(:a) # => true

# Common pattern for optional keys
settings = {theme: "dark", language: "en"}
if settings.include?(:debug)
  enable_debugging
end
```

**Alias of:** `has_key?`

**Also aliased by:** `key?`, `member?`