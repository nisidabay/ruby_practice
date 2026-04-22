# [] (Array.[])

Creates a new array from the given objects, without needing to call `new` explicitly.

```ruby
# Creating arrays with literal syntax
arr = [1, 2, 3, 4, 5]
arr # => [1, 2, 3, 4, 5]

# Works with any objects
mixed = ['hello', 42, :symbol, [1, 2]]
mixed # => ["hello", 42, :symbol, [1, 2]]
```