# size

Returns the number of key-value pairs in the hash. Identical to `length`.

```ruby
h = {a: 1, b: 2, c: 3}

# Number of entries
h.size # => 3

# Empty hash
{}.size # => 0

# After modifications
h = {a: 1, b: 2}
h.size # => 2
h[:c] = 3
h.size # => 3
h.delete(:a)
h.size # => 2

# Useful for conditional logic
if h.size > 10
  process_large_hash
end
```

**Alias of:** `length`