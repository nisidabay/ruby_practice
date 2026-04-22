# shuffle

Returns a new array with elements in random order.

```ruby
arr = [1, 2, 3, 4, 5]

# Random order (changes each time)
arr.shuffle # => [3, 1, 5, 2, 4] (example)

# With random: option for reproducible results
arr.shuffle(random: Random.new(42)) # => deterministic order

# Original is unchanged
arr # => [1, 2, 3, 4, 5]
```