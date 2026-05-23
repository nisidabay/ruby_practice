# try_convert

Attempts to convert the object to a Hash using `to_hash`. Returns `nil` if conversion fails.

```ruby
# Successful conversion
Hash.try_convert({a: 1}) # => {:a=>1}

# Object with to_hash
class MyHash
  def to_hash
    {x: 1, y: 2}
  end
end
Hash.try_convert(MyHash.new) # => {:x=>1, :y=>2}

# Conversion fails
Hash.try_convert("not a hash") # => nil
Hash.try_convert([1, 2, 3]) # => nil

# Useful for type checking in methods
def process(data)
  h = Hash.try_convert(data)
  return nil unless h
  h.transform_keys(&:to_s)
end
process({a: 1}) # => {"a"=>1}
process("invalid") # => nil
```