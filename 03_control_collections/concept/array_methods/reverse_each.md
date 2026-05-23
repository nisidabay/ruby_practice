# reverse_each

Iterates over elements in reverse order, from last to first.

```ruby
arr = [1, 2, 3, 4, 5]

# Iterate in reverse
arr.reverse_each { |n| puts n } # prints: 5, 4, 3, 2, 1

# Returns self
arr.reverse_each { |n| n } # => [1, 2, 3, 4, 5]

# Returns enumerator if no block
enum = arr.reverse_each # => #<Enumerator: ...>

# Useful when you need to process from end
arr.reverse_each { |n| puts "Processing: #{n}" }
```