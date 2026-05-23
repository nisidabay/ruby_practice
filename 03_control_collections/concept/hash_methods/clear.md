# clear

Removes all key-value pairs from the hash. Returns self (the empty hash).

```ruby
h = {a: 1, b: 2, c: 3}

# Clear all entries
h.clear
h # => {}

# Returns self (the same object, now empty)
h = {a: 1}
result = h.clear
result.equal?(h) # => true

# Chain operations (continues on same empty hash)
{a: 1, b: 2}.clear.merge!(x: 0) # => {:x=>0}

# Compare with reassignment
h = {a: 1}
h.clear # modifies same object
h = {a: 1}
h = {} # creates new object

# After clear, default/default_proc remain
h = Hash.new(0)
h[:a] = 1
h.clear
h[:missing] # => 0 (default still works)
```