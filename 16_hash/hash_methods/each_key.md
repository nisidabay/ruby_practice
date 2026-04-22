# each_key

Iterates over keys, yielding each key to the block. Returns self.

```ruby
h = {a: 1, b: 2, c: 3}

# Iterate over keys only
h.each_key { |key| puts key }
# prints: a, b, c

# Returns self
result = h.each_key { |k| k }
result # => {:a=>1, :b=>2, :c=>3}

# Returns enumerator if no block
enum = h.each_key
enum.to_a # => [:a, :b, :c]

# More efficient than each when you only need keys
h.each { |k, v| process_key(k) } # creates unused v variable
h.each_key { |k| process_key(k) } # cleaner

# Build array of processed keys
keys = []
h.each_key { |k| keys << k.to_s.upcase }
keys # => ["A", "B", "C"]
```