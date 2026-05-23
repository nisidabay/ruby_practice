# to_h

Converts the array to a hash, treating each element as a key-value pair.

```ruby
# Array of two-element arrays
arr = [[:a, 1], [:b, 2], [:c, 3]]
arr.to_h # => {:a => 1, :b => 2, :c => 3}

# With block for conversion
arr = ['a', 'b', 'c']
arr.to_h { |char| [char, char.upcase] } # => {"a" => "A", "b" => "B", "c" => "C"}

# Array of pairs
[[1, 'one'], [2, 'two']].to_h # => {1 => "one", 2 => "two"}

# Raises error if elements are not key-value pairs
[1, 2, 3].to_h # => TypeError: wrong element type
```