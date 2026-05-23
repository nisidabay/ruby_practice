# default_proc=

Sets the default proc for the hash to handle missing keys.

```ruby
h = {}

# Set default proc
h.default_proc = proc { |hash, key| "missing: #{key}" }
h[:x] # => "missing: :x"

# Auto-populate pattern
h = {}
h.default_proc = proc { |hash, key| hash[key] = [] }
h[:fruits] << "apple"
h[:fruits] << "banana"
h # => {:fruits=>["apple", "banana"]}

# Counter pattern
word_count = {}
word_count.default_proc = proc { |h, k| h[k] = 0 }
words = %w[apple banana apple cherry banana apple]
words.each { |w| word_count[w] += 1 }
word_count # => {"apple"=>3, "banana"=>2, "cherry"=>1}

# Cache pattern
cache = {}
cache.default_proc = proc { |h, k| h[k] = expensive_calculation(k) }
```

**Note:** Setting default_proc clears any default value.