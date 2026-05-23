# compact

Returns a new array without `nil` values.

```ruby
arr = [1, nil, 2, nil, 3, nil]
arr.compact # => [1, 2, 3]

# Original is unchanged
arr # => [1, nil, 2, nil, 3, nil]

# No nil values
[1, 2, 3].compact # => [1, 2, 3]

# Only nil values
[nil, nil].compact # => []
```