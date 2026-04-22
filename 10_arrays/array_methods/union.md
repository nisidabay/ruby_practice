# | (Union)

Returns a new array with all unique elements from both arrays (set union).

```ruby
a = [1, 2, 3]
b = [3, 4, 5]

a | b # => [1, 2, 3, 4, 5]

# Order: all from first, then new from second
[3, 2, 1] | [1, 4, 3] # => [3, 2, 1, 4]

# Removes duplicates within each array
[1, 1, 2] | [2, 3, 3] # => [1, 2, 3]

# Originals are unchanged
a # => [1, 2, 3]
```