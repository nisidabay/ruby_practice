# update

Destructively merges other hashes into self. Identical to `merge!`.

```ruby
h1 = {a: 1, b: 2}

# Update in place
h1.update({b: 3, c: 4})
h1 # => {:a=>1, :b=>3, :c=>4}

# Returns self
result = {x: 1}.update({y: 2})
result # => {:x=>1, :y=>2}

# Update multiple at once
h = {}
h.update({a: 1}, {b: 2}, {c: 3})
h # => {:a=>1, :b=>2, :c=>3}

# With block for conflict resolution
h = {x: 10, y: 20}
h.update({y: 30, z: 40}) { |key, old, new| [old, new].max }
h # => {:x=>10, :y=>30, :z=>40}
```

**Alias of:** `merge!`