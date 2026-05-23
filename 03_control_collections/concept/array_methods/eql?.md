# eql?

Compares arrays for equality using `eql?` for element comparison (stricter than `==`).

```ruby
# Same objects
[1, 2, 3].eql?([1, 2, 3]) # => true

# Stricter than == for numeric comparison
[1, 2, 3].eql?([1.0, 2.0, 3.0]) # => false (Integer != Float)

# For comparison, == returns true:
[1, 2, 3] == [1.0, 2.0, 3.0] # => true
```