# replace

Replaces the contents of the hash with another hash's contents. Returns self.

```ruby
h = {a: 1, b: 2}

# Replace contents
h.replace({c: 3, d: 4})
h # => {:c=>3, :d=>4}

# Returns self (same object)
h1 = {a: 1}
h2 = {b: 2}
result = h1.replace(h2)
h1 # => {:b=>2}
h1.equal?(result) # => true

# Original hash object preserved (same object_id)
h = {a: 1, b: 2}
id = h.object_id
h.replace({x: 1})
h.object_id == id # => true (same object)

# Replace with empty hash
h = {a: 1, b: 2}
h.replace({})
h # => {}

# Default value preserved from original
h = Hash.new(0)
h[:a] = 1
h.replace({b: 2})
h[:missing] # => 0 (default from original)
```