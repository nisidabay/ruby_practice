# length

Returns the number of key-value pairs in the hash.

```ruby
h = {a: 1, b: 2, c: 3}

# Number of entries
h.length # => 3

# Empty hash
{}.length # => 0

# Large hash
h = {a:1, b:2, c:3, d:4, e:5, f:6, g:7, h:8, i:9, j:10}
h.length # => 10

# Check if empty
h.length == 0 # => false (use h.empty? instead)
h.length > 0 # => true (use !h.empty? instead)

# After modification
h = {a: 1, b: 2}
h.delete(:a)
h.length # => 1
```

**Alias:** `size`