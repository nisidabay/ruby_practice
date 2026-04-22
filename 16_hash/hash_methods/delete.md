# delete

Deletes a key-value pair from the hash. Returns the value if found, or the result of block if provided.

```ruby
h = {a: 1, b: 2, c: 3}

# Delete by key
h.delete(:b) # => 2
h # => {:a=>1, :c=>3}

# Key not found returns nil
h = {a: 1}
h.delete(:z) # => nil

# With default block (key not found)
h = {a: 1}
h.delete(:z) { |key| "key #{key} not found" } # => "key :z not found"

# Useful for one-time removal
config = {debug: true, name: "app"}
debug_value = config.delete(:debug)
debug_value # => true
config # => {:name=>"app"}

# Block not executed if key found
h = {a: 1}
h.delete(:a) { expensive_operation } # => 1 (block not called)
```