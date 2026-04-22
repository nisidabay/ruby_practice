# [] (Element Reference)

Returns the value for a given key. If the key is not found, returns the default value.

```ruby
h = {a: 1, b: 2, c: 3}

# Access by key
h[:a] # => 1
h[:b] # => 2
h[:z] # => nil (key not found)

# With default value
h = Hash.new(0)
h[:missing] # => 0

# With default block
h = Hash.new { |hash, key| "missing: #{key}" }
h[:x] # => "missing: :x"

# String keys
h = {"name" => "Alice", "age" => 30}
h["name"] # => "Alice"

# Multiple access patterns
h = {a: 1, b: 2}
h[:a] # => 1
h[:missing] # => nil
```