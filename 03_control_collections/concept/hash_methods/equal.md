# equal?

Returns `true` if hashes are the same object (same object_id). Uses object identity.

```ruby
# Same object
h = {a: 1, b: 2}
h.equal?(h) # => true

# Different objects, same content
h1 = {a: 1, b: 2}
h2 = {a: 1, b: 2}
h1.equal?(h2) # => false (different objects)

# Compare with == and eql?
h1 == h2 # => true (same content)
h1.eql?(h2) # => true (same content)
h1.equal?(h2) # => false (different objects)

# Object identity check
def same_object?(a, b)
  a.equal?(b)
end
h = {a: 1}
same_object?(h, h) # => true
same_object?(h, {a: 1}) # => false

# Useful for identity comparison
a = {x: 1}
b = a
c = {x: 1}
a.equal?(b) # => true (same reference)
a.equal?(c) # => false (different objects, same content)
```