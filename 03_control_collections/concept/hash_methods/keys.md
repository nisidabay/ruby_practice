# keys

Returns an array of all keys in the hash.

```ruby
h = {a: 1, b: 2, c: 3}

# All keys
h.keys # => [:a, :b, :c]

# Order preserved (Ruby 1.9+)
h = {c: 3, b: 2, a: 1}
h.keys # => [:c, :b, :a]

# Empty hash
{}.keys # => []

# Count keys
h.keys.length # => 3
h.keys.count # => 3

# Check if key exists
h.keys.include?(:a) # => true (but use h.key?(:a) instead)

# Process all keys
h.keys.each { |k| puts k }
h.keys.map(&:to_s) # => ["a", "b", "c"]

# String keys
{"a" => 1, "b" => 2}.keys # => ["a", "b"]
```