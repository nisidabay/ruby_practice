# hash

Returns an integer hash code for the hash. Used for hash table lookup.

```ruby
h = {a: 1, b: 2}

# Hash code
h.hash # => integer (varies)

# Same content, same hash code
{a: 1}.hash == {a: 1}.hash # => true

# Different content, different hash code
{a: 1}.hash == {b: 1}.hash # => generally false

# Order matters for hash code (Ruby 1.9+)
{a: 1, b: 2}.hash == {b: 2, a: 1}.hash # => false (different orders)

# Use eql? for content comparison, not hash
h1 = {a: 1, b: 2}
h2 = {a: 1, b: 2}
h1.eql?(h2) # => true (same content)

# Hash as key in another hash
meta = {version: 1}
config = {meta => "data"}
config[{version: 1}] # => "data" (works, but rare pattern)
```