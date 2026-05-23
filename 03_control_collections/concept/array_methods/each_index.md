# each_index

Iterates over each index, yielding it to the block. Returns self.

```ruby
arr = ['a', 'b', 'c']

# Iterate with index
arr.each_index { |i| puts i } # prints: 0, 1, 2

# Useful when you only need indices
arr.each_index { |i| puts "Index #{i} has value #{arr[i]}" }
# prints: Index 0 has value a, Index 1 has value b, etc.

# Returns enumerator if no block
enum = arr.each_index # => #<Enumerator: ...>

# Returns self
arr.each_index { } # => ["a", "b", "c"]
```