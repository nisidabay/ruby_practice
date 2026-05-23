# include?

Returns `true` if the given object is present in the array, using `==` for comparison.

```ruby
arr = ['apple', 'banana', 'cherry']
arr.include?('banana') # => true
arr.include?('grape') # => false

# Works with numbers
[1, 2, 3, 4, 5].include?(3) # => true
```