# bsearch

Performs binary search to find an element. Array must be sorted for meaningful results.

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Find element (returns the element)
arr.bsearch { |x| x >= 5 } # => 5
arr.bsearch { |x| x >= 7 } # => 7

# Returns nil if not found
arr.bsearch { |x| x > 100 } # => nil

# Works with any comparison in sorted array
words = ['apple', 'banana', 'cherry', 'date']
words.bsearch { |w| w >= 'cherry' } # => "cherry"
```