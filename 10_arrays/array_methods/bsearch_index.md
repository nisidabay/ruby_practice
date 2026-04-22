# bsearch_index

Performs binary search and returns the index of the found element. Array must be sorted.

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Find index
arr.bsearch_index { |x| x >= 5 } # => 4
arr.bsearch_index { |x| x >= 7 } # => 6

# Returns nil if not found
arr.bsearch_index { |x| x > 100 } # => nil

# Useful when you need the position, not the value
words = ['apple', 'banana', 'cherry', 'date']
words.bsearch_index { |w| w >= 'cherry' } # => 2
```