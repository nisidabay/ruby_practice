# shift

Removes and returns the first key-value pair as a two-element array. Returns `nil` if hash is empty.

```ruby
h = {a: 1, b: 2, c: 3}

# Remove first pair
h.shift # => [:a, 1]
h # => {:b=>2, :c=>3}

# Shift returns array of [key, value]
h = {x: 10, y: 20}
pair = h.shift
pair # => [:x, 10]

# Empty hash returns nil
{}.shift # => nil

# Useful for FIFO queue pattern
queue = {first: 1, second: 2, third: 3}
while (item = queue.shift)
  puts item
end
# prints: [:first, 1], [:second, 2], [:third, 3]

# Destructure directly
key, value = h.shift
```