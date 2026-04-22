# store

Sets the value for a given key. Identical to `[]=`.

```ruby
h = {}

# Store a value
h.store(:a, 1)
h # => {:a=>1}

# Overwrite existing value
h.store(:a, 2)
h # => {:a=>2}

# Returns the stored value
h.store(:b, 3) # => 3

# Compare with []=
h[:c] = 4 # same as h.store(:c, 4)

# Useful for method chaining clarity
h.store(:x, 1).store(:y, 2) # No - returns value, not self

# Works with any key type
h.store("string", "key")
h.store(123, "number key")
```

**Alias of:** `[]=` (store is the method name for `[]=`)