# eql?

Returns `true` if hashes have same content (keys and values). Used for hash comparison.

```ruby
# Same content
{a: 1}.eql?({a: 1}) # => true
{a: 1, b: 2}.eql?({a: 1, b: 2}) # => true

# Different content
{a: 1}.eql?({a: 2}) # => false
{a: 1}.eql?({b: 1}) # => false

# Order doesn't matter for eql?
{a: 1, b: 2}.eql?({b: 2, a: 1}) # => true

# Type matters
{a: 1}.eql?({"a" => 1}) # => false (symbol vs string key)
{a: 1}.eql?([[:a, 1]]) # => false (hash vs array)

# Same object
h = {a: 1}
h.eql?(h) # => true

# Compare with ==
# == uses eql? internally but also handles type conversion
{a: 1} == {a: 1} # => true (same as eql?)
```