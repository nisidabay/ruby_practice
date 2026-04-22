# empty?

Returns `true` if the hash has no key-value pairs, `false` otherwise.

```ruby
# Empty hash
{}.empty? # => true

# Non-empty hash
{a: 1}.empty? # => false
{nil => nil}.empty? # => false (has one entry)

# Check before operations
h = {}
if h.empty?
  puts "Hash is empty"
end

# After deleting all entries
h = {a: 1, b: 2}
h.clear
h.empty? # => true

# Common pattern: guard clause
def process(hash)
  return if hash.empty?
  # process...
end

# Compare with size/length
{}.size == 0 # true (but empty? is more readable)
{}.empty? # true (preferred)
```