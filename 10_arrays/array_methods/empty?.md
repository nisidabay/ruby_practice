# empty?

Returns `true` if the array contains no elements.

```ruby
[].empty? # => true

[1, 2, 3].empty? # => false

# Useful for conditional checks
arr = []
puts "No items" if arr.empty? # => "No items"
```