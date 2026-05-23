# sample

Returns a random element or `n` random elements from the array.

```ruby
arr = [1, 2, 3, 4, 5]

# Single random element
arr.sample # => 3 (random each time)

# Multiple random elements (no duplicates)
arr.sample(3) # => [2, 5, 1] (example)

# More samples than elements returns all
arr.sample(10) # => [3, 1, 5, 4, 2] (shuffled, all elements)

# With random: option for reproducibility
arr.sample(random: Random.new(42)) # => deterministic
```