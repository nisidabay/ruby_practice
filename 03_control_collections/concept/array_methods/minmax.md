# minmax

Returns a two-element array containing the minimum and maximum values.

```ruby
arr = [3, 1, 4, 1, 5, 9, 2, 6]

arr.minmax # => [1, 9]

# With block for custom comparison
['apple', 'pie', 'strawberry'].minmax { |a, b| a.length <=> b.length }
# => ["pie", "strawberry"]

# Empty array
[].minmax # => [nil, nil]
```