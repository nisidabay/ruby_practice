# filter!

Destructively removes all entries for which the block returns `false` or `nil`. Identical to `select!`.

```ruby
h = {a: 1, b: 2, c: 3, d: 4}

# Keep only even values
h.filter! { |k, v| v.even? }
h # => {:b=>2, :d=>4}

# Returns self if changes made
h = {a: 1, b: 2}
result = h.filter! { |k, v| v.even? }
result # => {:b=>2}

# Returns nil if no changes
h = {a: 1, b: 2}
h.filter! { |k, v| v.is_a?(Integer) } # => nil

# Block receives key-value pair
h = {a: "apple", b: "banana", c: "cherry"}
h.filter! { |k, v| v.start_with?("a") }
h # => {:a=>"apple"}
```

**Alias of:** `select!`