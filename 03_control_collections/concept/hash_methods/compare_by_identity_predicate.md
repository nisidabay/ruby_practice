# compare_by_identity?

Returns `true` if hash compares keys by identity, `false` otherwise.

```ruby
# Normal hash
h = {a: 1, b: 2}
h.compare_by_identity? # => false

# Compare by identity hash
h = {}
h.compare_by_identity
h.compare_by_identity? # => true

# Check after setting
h = {a: 1}
h.compare_by_identity? # => false
h.compare_by_identity
h.compare_by_identity? # => true

# Cannot be undone
h = {}
h.compare_by_identity
h.compare_by_identity? # => true
# No method to return to normal comparison

# Useful check for debugging
def process_hash(h)
  if h.compare_by_identity?
    "Key comparison by identity (object_id)"
  else
    "Key comparison by equality (eql?/hash)"
  end
end
```

**Note:** Once `compare_by_identity` is set, this returns `true` permanently for that hash.