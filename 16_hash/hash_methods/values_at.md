# values_at

Returns an array of values for the given keys. Returns `nil` for keys not found.

```ruby
h = {a: 1, b: 2, c: 3}

# Get values by keys
h.values_at(:a, :b) # => [1, 2]
h.values_at(:a, :b, :c) # => [1, 2, 3]

# Order preserved
h.values_at(:c, :a, :b) # => [3, 1, 2]

# Missing keys return nil
h.values_at(:a, :missing) # => [1, nil]

# Multiple missing keys
h.values_at(:x, :y, :z) # => [nil, nil, nil]

# With default value hash
h = Hash.new(0)
h[:a] = 1
h.values_at(:a, :b) # => [1, 0]

# Useful for extracting multiple values
person = {name: "Alice", age: 30, city: "NYC"}
name, age = person.values_at(:name, :age)
```