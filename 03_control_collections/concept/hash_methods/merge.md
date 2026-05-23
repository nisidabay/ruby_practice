# merge

Returns a new hash combining self with other hashes. Values from other hashes take precedence.

```ruby
h1 = {a: 1, b: 2}
h2 = {b: 3, c: 4}

# Merge two hashes
h1.merge(h2) # => {:a=>1, :b=>3, :c=>4}

# Original unchanged
h1 # => {:a=>1, :b=>2}

# Merge multiple hashes
{a: 1}.merge({b: 2}, {c: 3}) # => {:a=>1, :b=>2, :c=>3}

# With block to resolve conflicts
h1 = {a: 1, b: 2}
h2 = {b: 3, c: 4}
h1.merge(h2) { |key, old, new| old + new }
# => {:a=>1, :b=>5, :c=>4}

# Block receives key, old value, new value
{a: "old"}.merge({a: "new"}) { |k, o, n| "#{o}+#{n}" }
# => {:a=>"old+new"}

# Right-most wins for duplicates
{a: 1}.merge({a: 2}, {a: 3}) # => {:a=>3}
```