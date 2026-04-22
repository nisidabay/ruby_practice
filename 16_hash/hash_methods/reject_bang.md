# reject!

Destructively removes entries for which the block returns `true`. Returns self if changes, `nil` otherwise.

```ruby
h = {a: 1, b: 2, c: 3, d: 4}

# Remove even values
h.reject! { |k, v| v.even? }
h # => {:a=>1, :c=>3}

# Returns self if changes made
h = {a: 1, b: 2}
result = h.reject! { |k, v| v.even? }
result # => {:a=>1}
result.equal?(h) # => true

# Returns nil if no changes
h = {a: 1, b: 2}
h.reject! { |k, v| v > 10 } # => nil (nothing removed)
h # => {:a=>1, :b=>2}

# Returns enumerator if no block
enum = h.reject!

# Common pattern: compact
config = {a: 1, b: nil, c: 3, d: nil}
config.reject! { |k, v| v.nil? }
config # => {:a=>1, :c=>3}
```