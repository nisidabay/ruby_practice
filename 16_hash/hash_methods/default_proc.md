# default_proc

Returns the default block (proc) for the hash, or `nil` if none was set.

```ruby
# Hash without default proc
h = {}
h.default_proc # => nil

# Hash with default block
h = Hash.new { |hash, key| "default for #{key}" }
h.default_proc # => #<Proc:...>

# Hash with default value (not proc)
h = Hash.new(0)
h.default_proc # => nil

# Inspecting the proc
h = Hash.new { |h, k| h[k] = [] }
proc = h.default_proc
proc.call(h, :new_key) # => []
h # => {:new_key=>[]}

# Conditional default
h = Hash.new do |hash, key|
  hash[key] = key.to_s.upcase
end
h[:hello] # => "HELLO"
h # => {:hello=>"HELLO"}
```