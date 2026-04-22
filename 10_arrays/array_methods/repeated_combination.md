# repeated_combination

Yields all combinations of elements taken `n` at a time, allowing repeated elements.

```ruby
arr = [1, 2]

# Repeated combinations of 2
arr.repeated_combination(2).to_a # => [[1, 1], [1, 2], [2, 2]]

# Repeated combinations of 3
arr.repeated_combination(3).to_a # => [[1, 1, 1], [1, 1, 2], [1, 2, 2], [2, 2, 2]]

# Order is preserved (smaller first)
[2, 1].repeated_combination(2).to_a # => [[2, 2], [2, 1], [1, 1]]

# Useful for generating all possible selections with replacement
# With block
arr.repeated_combination(2) { |combo| puts combo.inspect }
```