# initialize_copy

Called when hash is copied (via `dup` or `clone`). Used to customize deep copy behavior. Normally not called directly.

```ruby
# Hash doesn't expose initialize_copy publicly
# It's called internally during dup/clone operations

# Standard copy (shallow copy)
h1 = {a: [1, 2], b: [3, 4]}
h2 = h1.dup
h2[:a] << 5
h1[:a] # => [1, 2, 5] (shallow copy shares arrays!)

# For deep copy, use Marshal
h1 = {a: [1, 2], b: [3, 4]}
h2 = Marshal.load(Marshal.dump(h1))
h2[:a] << 5
h1[:a] # => [1, 2] (deep copy, separate arrays)

# Custom class with initialize_copy
class CustomHash < Hash
  def initialize_copy(original)
    super
    # Deep copy values
    each { |k, v| self[k] = v.dup if v.respond_to?(:dup) }
  end
end

h1 = CustomHash.new
h1[:a] = [1, 2]
h2 = h1.dup
h2[:a] << 3
h1[:a] # => [1, 2] (deep copied)

# Note: Hash's internal initialize_copy is private
h = {a: 1}
h.respond_to?(:initialize_copy) # => true
h.method(:initialize_copy) # => #<Method: Hash#initialize_copy> (private)
```

**Note:** This is a private method called automatically during `dup`/`clone`. Override in subclasses for custom copy behavior.