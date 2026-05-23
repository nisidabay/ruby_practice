# inspect

Returns a string representation suitable for debugging.

```ruby
h = {a: 1, b: 2}

# Debug representation
h.inspect # => "{:a=>1, :b=>2}"

# Same as to_s for Hash
h.to_s # => "{:a=>1, :b=>2}"

# With nested hashes
h = {user: {name: "Alice", age: 30}}
h.inspect # => "{:user=>{:name=>\"Alice\", :age=>30}}"

# Different key types
{"key" => "value"}.inspect # => "{\"key\"=>\"value\"}"
{1 => "one"}.inspect # => "{1=>\"one\"}"

# Useful in irb/debugging
p h # prints h.inspect
pp h # pretty prints nested structures
```