# <=> (Spaceship)

Compares arrays element by element, returning -1, 0, or 1 depending on ordering.

```ruby
# Returns -1 if self is less than other
[1, 2, 3] <=> [1, 2, 4] # => -1

# Returns 0 if equal
[1, 2, 3] <=> [1, 2, 3] # => 0

# Returns 1 if self is greater
[1, 2, 4] <=> [1, 2, 3] # => 1

# Shorter array is "less than"
[1, 2] <=> [1, 2, 3] # => -1

# Useful for custom sorting in classes
```