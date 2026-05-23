# member?

Returns `true` if the key exists in the hash, `false` otherwise.

```ruby
h = {a: 1, b: 2, c: 3}

# Key exists
h.member?(:a) # => true
h.member?(:b) # => true

# Key doesn't exist
h.member?(:z) # => false

# Useful in conditional logic
case
when h.member?(:admin)
  "Admin access"
when h.member?(:user)
  "User access"
else
  "No access"
end
```

**Alias of:** `has_key?`

**Also aliased by:** `key?`, `include?`