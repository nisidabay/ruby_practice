# each_value

Iterates over values, yielding each value to the block. Returns self.

```ruby
h = {a: 1, b: 2, c: 3}

# Iterate over values only
h.each_value { |value| puts value * 2 }
# prints: 2, 4, 6

# Returns self
result = h.each_value { |v| v }
result # => {:a=>1, :b=>2, :c=>3}

# Returns enumerator if no block
enum = h.each_value
enum.to_a # => [1, 2, 3]

# More efficient than each when you only need values
h.each { |k, v| process(v) } # creates unused k variable
h.each_value { |v| process(v) } # cleaner

# Sum values without creating array
sum = 0
h.each_value { |v| sum += v }
sum # => 6
```