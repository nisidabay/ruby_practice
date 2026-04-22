# zip

Combines elements from self with elements from other arrays.

```ruby
a = [1, 2, 3]
b = ['a', 'b', 'c']

a.zip(b) # => [[1, "a"], [2, "b"], [3, "c"]]

# With multiple arrays
a = [1, 2, 3]
a.zip([10, 20, 30], [100, 200, 300])
# => [[1, 10, 100], [2, 20, 200], [3, 30, 300]]

# Handles different lengths (fills with nil)
[1, 2].zip([10, 20, 30]) # => [[1, 10], [2, 20]]

# Uses nil for missing values
[1, 2, 3].zip([10, 20]) # => [[1, 10], [2, 20], [3, nil]]

# With block
[1, 2].zip([3, 4]) { |a, b| puts "#{a} + #{b} = #{a + b}" }
# prints: 1 + 3 = 4, 2 + 4 = 6
```