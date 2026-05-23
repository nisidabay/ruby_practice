# compare_by_identity

Makes the hash compare keys by identity (object_id) instead of equality. Returns self.

```ruby
# Normal hash uses eql? for key comparison
h = {}
s1 = "key"
s2 = "key"
h[s1] = 1
h[s2] # => 1 (same string content, same key)

# Compare by identity
h = {}
h.compare_by_identity
s1 = "key"
s2 = "key"
h[s1] = 1
h[s2] = 2
h # => {"key"=>1, "key"=>2} (different objects, different keys!)

# Symbol comparisons (interned strings)
h = {}
h.compare_by_identity
h[:a] = 1
h[:a] = 2 # Overwrites (same object)
h # => {:a=>2}

# Useful for caching objects by identity
cache = {}
cache.compare_by_identity
obj1 = Object.new
obj2 = Object.new
cache[obj1] = "data1"
cache[obj2] = "data2"

# Returns self
h = {a: 1}
result = h.compare_by_identity
result.equal?(h) # => true
```

**Note:** Once set, cannot be undone. Keys are compared by `object_id` instead of `eql?` and `hash`.