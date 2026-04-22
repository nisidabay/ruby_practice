# assoc

Returns the key-value pair as a two-element array if the key exists, or `nil`.

```ruby
h = {a: 1, b: 2, c: 3}

# Find pair by key
h.assoc(:a) # => [:a, 1]
h.assoc(:b) # => [:b, 2]

# Key not found
h.assoc(:z) # => nil

# Works with any key type
h = {"name" => "Alice", "age" => 30}
h.assoc("name") # => ["name", "Alice"]

# Useful for destructuring pair
if pair = h.assoc(:a)
  key, value = pair
  puts "#{key} = #{value}"
end

# Compare with []
h[:a] # => 1 (just value)
h.assoc(:a) # => [:a, 1] (key-value pair)

# Works well with case
case h.assoc(:status)
in [:status, "success"] then process_success
in [:status, "error"] then handle_error
end
```