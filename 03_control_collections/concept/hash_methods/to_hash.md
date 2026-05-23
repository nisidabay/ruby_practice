# to_hash

Returns self. Used for implicit conversion protocols.

```ruby
h = {a: 1, b: 2}

# Returns self
h.to_hash # => {:a=>1, :b=>2}
h.to_hash.equal?(h) # => true

# Used for implicit conversion (called when Hash is expected)
def accepts_hash(obj)
  obj.to_hash
end
accepts_hash({a: 1}) # => {:a=>1}

# Differs from to_h
# to_h - explicit conversion (called explicitly)
# to_hash - implicit conversion (called automatically by Ruby)

# Custom class example
class Config
  def initialize(data)
    @data = data
  end
  
  def to_hash
    @data
  end
end
```