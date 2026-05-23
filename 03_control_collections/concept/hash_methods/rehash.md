# rehash

Rebuilds the hash based on current key values. Needed when key objects are modified.

```ruby
# When keys are mutable objects
s = "key"
h = {s => "value"}
h["key"] # => "value"

# Modify the key object
s.upcase! # => "KEY"
h # => {"KEY"=>"value"} (key changed!)
h["KEY"] # => nil (hash lookup broken!)

# Rehash fixes lookup
h.rehash
h["KEY"] # => "value" (now works)

# Common scenario with strings
keys = ["a", "b", "c"]
h = {keys => "value"}
keys.map!(&:upcase) # keys now ["A", "B", "C"]
h.rehash # fixes the hash

# Keys that don't change don't need rehash
h = {a: 1, b: 2}
h.rehash # safe but unnecessary

# Returns self
h = {a: 1}
result = h.rehash
result.equal?(h) # => true
```

**Note:** Needed when key objects are modified in-place. Immutable keys (symbols, numbers) don't require rehash.