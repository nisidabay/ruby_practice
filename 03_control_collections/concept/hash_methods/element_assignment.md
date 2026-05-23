# []= (Element Assignment)

Sets the value for a given key. Updates the value if key already exists.

```ruby
h = {}

# Add new key-value pair
h[:a] = 1
h # => {:a=>1}

# Update existing key
h[:a] = 2
h # => {:a=>2}

# Multiple assignments
h[:b] = 2
h[:c] = 3
h # => {:a=>2, :b=>2, :c=>3}

# Returns the assigned value
result = (h[:d] = 4) # => 4

# String keys
h = {}
h["name"] = "Alice"
h # => {"name"=>"Alice"}

# Any object can be a key (but be careful with mutable objects)
h[Symbol] = "class as key"
h[1] = "integer key"
h # => {:a=>2, :b=>2, :c=>3, :d=>4, Symbol=>"class as key", 1=>"integer key"}
```