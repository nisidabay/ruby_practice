# compact!

Destructively removes all `nil` values from the hash. Returns self if changes, `nil` otherwise. Ruby 2.4+.

```ruby
h = {a: 1, b: nil, c: 3}

# Remove nil values in place
h.compact!
h # => {:a=>1, :c=>3}

# Returns self if changes made
h = {a: 1, b: nil}
result = h.compact!
result.equal?(h) # => true

# Returns nil if no changes
h = {a: 1, b: 2}
h.compact! # => nil (no nil values to remove)
h # => {:a=>1, :b=>2}

# Modifies original, unlike compact
h1 = {a: 1, b: nil}
h2 = {a: 1, b: nil}
h1.compact! # => {:a=>1} (destructive)
h2.compact # => {:a=>1} (h2 unchanged)

# Useful for cleaning API params
params = {name: "Alice", age: nil, city: "NYC", phone: nil}
params.compact!
params # => {:name=>"Alice", :city=>"NYC"}
```

**Note:** Available in Ruby 2.4+