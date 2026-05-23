# shuffle!

Shuffles the array in place (destructive).

```ruby
arr = [1, 2, 3, 4, 5]

arr.shuffle! # => random order, e.g., [3, 1, 5, 2, 4]

# Original is modified
arr # => [3, 1, 5, 2, 4] (shuffled)

# With random: for reproducible shuffle
arr = [1, 2, 3, 4, 5]
arr.shuffle!(random: Random.new(42)) # => deterministic order
```