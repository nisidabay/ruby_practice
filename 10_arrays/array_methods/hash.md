# hash

Returns an integer hash code for the array, computed from the hash codes of its elements.

```ruby
# Hash codes for equality comparison
[1, 2, 3].hash # => a unique integer

# Equal arrays have equal hash codes
[1, 2, 3].hash == [1, 2, 3].hash # => true

# Different arrays have different hash codes
[1, 2, 3].hash == [3, 2, 1].hash # => false
```