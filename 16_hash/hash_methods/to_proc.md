# to_proc

Returns a proc that maps keys to values. Useful for functional programming patterns.

```ruby
h = {a: 1, b: 2, c: 3}

# Create a proc from hash
proc = h.to_proc
proc.call(:a) # => 1
proc.call(:b) # => 2
proc.call(:z) # => nil (key not found)

# Use with map for key lookups
h = {name: "Alice", age: 30}
keys = [:name, :age]
keys.map(&h) # => ["Alice", 30]

# Missing keys return nil
keys = [:name, :email]
keys.map(&h) # => ["Alice", nil]

# With default value
h = Hash.new("unknown")
h[:name] = "Alice"
[:name, :email].map(&h) # => ["Alice", "unknown"]

# Useful for translations
dictionary = {hello: "hola", goodbye: "adiós"}
[:hello, :goodbye].map(&dictionary) # => ["hola", "adiós"]
```