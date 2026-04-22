# new

Creates a new Hash. Can be called with a default value, default block, or an existing hash.

```ruby
# Empty hash with nil default
h = Hash.new # => {}

# Hash with default value
h = Hash.new(0)
h[:a] # => 0 (returns default, doesn't store)
h[:b] = 1
h # => {:b=>1}

# Hash with default block
h = Hash.new { |hash, key| hash[key] = "default for #{key}" }
h[:a] # => "default for :a"
h # => {:a=>"default for :a"}

# From another hash
Hash.new({a: 1}) # => {}

# From array of pairs
Hash[[[:a, 1], [:b, 2]]] # => {:a=>1, :b=>2}

# Literals are preferred
h = {} # simpler and more common
h = {a: 1, b: 2}
```