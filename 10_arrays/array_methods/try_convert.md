# try_convert

Attempts to convert the object to an array using `to_ary`, returns `nil` if conversion fails.

```ruby
# Successful conversion
Array.try_convert([1, 2, 3]) # => [1, 2, 3]

# Returns nil for non-convertible objects
Array.try_convert("hello") # => nil

# Works with objects that implement to_ary
class Wrapper
  def to_ary
    [1, 2, 3]
  end
end
Array.try_convert(Wrapper.new) # => [1, 2, 3]
```