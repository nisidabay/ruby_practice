# join

Returns a string created by joining all elements with a separator.

```ruby
arr = ['apple', 'banana', 'cherry']

# No separator (empty string)
arr.join # => "applebananacherry"

# With separator
arr.join(', ') # => "apple, banana, cherry"

# Numbers are converted to strings
[1, 2, 3].join('-') # => "1-2-3"

# Empty array
[].join(',') # => ""

# Nested arrays are flattened
[1, [2, 3], 4].join('-') # => "1-2-3-4"
```