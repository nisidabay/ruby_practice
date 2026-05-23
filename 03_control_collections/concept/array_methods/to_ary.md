# to_ary

Returns self (the array), used for implicit conversion to array.

```ruby
arr = [1, 2, 3]

arr.to_ary # => [1, 2, 3]

# Used internally by Ruby for splat operations
def example(*args)
  args
end
example(*[1, 2, 3]) # => [1, 2, 3] (uses to_ary)

# Difference from to_a: to_ary is for implicit conversion
# to_a is for explicit conversion
# For arrays, both return self
arr.to_ary.equal?(arr) # => true
```