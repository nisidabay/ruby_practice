# dig

Accesses nested elements in arrays (and hashes) through a sequence of keys/indices.

```ruby
# Nested arrays
arr = [[1, [2, 3]], [4, 5]]
arr.dig(0, 1) # => [2, 3]
arr.dig(0, 1, 0) # => 2

# Mixed array and hash
data = [{ name: 'Alice', address: { city: 'NYC' } }]
data.dig(0, :address, :city) # => "NYC"

# Returns nil for missing keys/indices
arr.dig(5, 0) # => nil
arr.dig(0, 5) # => nil
```