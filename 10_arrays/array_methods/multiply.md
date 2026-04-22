# * (Multiplication)

Returns a new array with repeated elements, or a string if joined with separator.

```ruby
# Array repetition
[1, 2, 3] * 3 # => [1, 2, 3, 1, 2, 3, 1, 2, 3]

# Original unchanged
arr = [1, 2]
arr * 2 # => [1, 2, 1, 2]
arr # => [1, 2]

# String separator (creates string)
['a', 'b', 'c'] * '-' # => "a-b-c"

# Same as join
['hello', 'world'] * ' ' # => "hello world"

# Empty separator
['a', 'b'] * '' # => "ab"

# Zero repetition
[1, 2, 3] * 0 # => []
```