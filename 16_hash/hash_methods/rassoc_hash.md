# rassoc

Returns the key-value pair as a two-element array if the value exists, or `nil`. Only returns first match.

```ruby
h = {a: 1, b: 2, c: 3}

# Find pair by value
h.rassoc(1) # => [:a, 1]
h.rassoc(2) # => [:b, 2]

# Value not found
h.rassoc(99) # => nil

# Returns first match if duplicate values
h = {a: 1, b: 1, c: 1}
h.rassoc(1) # => [:a, 1] (first only)

# Works with any value type
h = {name: "Alice", city: "NYC"}
h.rassoc("Alice") # => [:name, "Alice"]

# Useful for reverse lookup
codes = {us: "United States", uk: "United Kingdom"}
pair = codes.rassoc("United States")
pair # => [:us, "United States"]

# Compare with key method
h.key(1) # => :a (just key)
h.rassoc(1) # => [:a, 1] (key-value pair)
```