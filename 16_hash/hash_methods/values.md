# values

Returns an array of all values in the hash.

```ruby
h = {a: 1, b: 2, c: 3}

# All values
h.values # => [1, 2, 3]

# Order matches keys
h = {c: 3, b: 2, a: 1}
h.values # => [3, 2, 1]
h.keys # => [:c, :b, :a] (same order)

# Empty hash
{}.values # => []

# Duplicate values allowed
h = {a: 1, b: 1, c: 1}
h.values # => [1, 1, 1]

# Useful for value-based operations
h = {a: 1, b: 2, c: 3}
h.values.sum # => 6
h.values.max # => 3
h.values.min # => 1

# Values can be any type
h = {a: [1, 2], b: {x: 1}}
h.values # => [[1, 2], {:x=>1}]
```