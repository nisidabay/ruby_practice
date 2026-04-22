# sort_by!

Sorts the array in place by a given attribute or block result (destructive).

```ruby
# Sort strings by length
arr = ['elephant', 'cat', 'giraffe', 'dog']
arr.sort_by! { |w| w.length }
arr # => ["cat", "dog", "elephant", "giraffe"]

# Sort by attribute
users = [
  { name: 'Alice', age: 30 },
  { name: 'Bob', age: 25 },
  { name: 'Charlie', age: 35 }
]
users.sort_by! { |u| u[:age] }
users # => [Bob(25), Alice(30), Charlie(35)]

# Sort symbols
symbols = [:banana, :apple, :cherry]
symbols.sort_by! { |s| s.to_s } # => [:apple, :banana, :cherry]

# Using &:method syntax
strings = ['10', '5', '2', '8']
strings.sort_by!(&:to_i) # => ["2", "5", "8", "10"]
```