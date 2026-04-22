# to_a

Converts the array to an array (returns self for arrays).

```ruby
arr = [1, 2, 3]

arr.to_a # => [1, 2, 3]

# Useful for converting other objects to array
(1..5).to_a # => [1, 2, 3, 4, 5]
{a: 1, b: 2}.to_a # => [[:a, 1], [:b, 2]]
'string'.chars.to_a # => ["s", "t", "r", "i", "n", "g"]

# For arrays, returns self
arr.to_a.equal?(arr) # => true (same object)
```