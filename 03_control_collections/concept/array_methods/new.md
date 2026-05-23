# new

Creates a new empty array or an array with initial values and optional size.

```ruby
# Empty array
arr = Array.new
arr # => []

# Array with specific size
arr = Array.new(3)
arr # => [nil, nil, nil]

# Array with size and default value
arr = Array.new(3, 'x')
arr # => ["x", "x", "x"]

# Array with block (each element is evaluated separately)
arr = Array.new(3) { |i| i * 2 }
arr # => [0, 2, 4]
```