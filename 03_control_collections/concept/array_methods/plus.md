# + (Plus)

Returns a new array concatenating two arrays (non-destructive).

```ruby
a = [1, 2, 3]
b = [4, 5, 6]

a + b # => [1, 2, 3, 4, 5, 6]

# Originals are unchanged
a # => [1, 2, 3]
b # => [4, 5, 6]

# Works with different types
[1, 2] + ['a', 'b'] # => [1, 2, "a", "b"]
```