# each

Iterates over each element, yielding it to the block. Returns self.

```ruby
arr = [1, 2, 3, 4, 5]

# Iterate with block
arr.each { |n| puts n * 2 } # prints: 2, 4, 6, 8, 10

# Returns self
result = arr.each { |n| n }
result # => [1, 2, 3, 4, 5]

# With index
arr.each.with_index { |n, i| puts "#{i}: #{n}" } # prints: 0: 1, 1: 2, etc.

# Returns enumerator if no block
enum = arr.each # => #<Enumerator: ...>
```