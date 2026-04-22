# replace

Replaces the contents of the array with another array's contents (destructive).

```ruby
arr = [1, 2, 3]

arr.replace([4, 5, 6, 7]) # => [4, 5, 6, 7]

# Original object is modified (same object_id)
arr # => [4, 5, 6, 7]

# Reference is NOT shared with source
source = ['a', 'b']
arr = [1, 2, 3]
arr.replace(source)
source << 'c'
arr # => ["a", "b"] (unchanged, not same reference)
```