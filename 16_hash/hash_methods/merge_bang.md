# merge!

Destructively merges other hashes into self. Values from other hashes overwrite existing keys.

```ruby
h1 = {a: 1, b: 2}

# Merge in place
h1.merge!({b: 3, c: 4})
h1 # => {:a=>1, :b=>3, :c=>4}

# Returns self
result = {x: 1}.merge!({y: 2})
result # => {:x=>1, :y=>2}

# Merge multiple hashes
h = {}
h.merge!({a: 1}, {b: 2}, {c: 3})
h # => {:a=>1, :b=>2, :c=>3}

# With block to resolve conflicts
h = {a: 1, b: 2}
h.merge!({b: 3, c: 4}) { |key, old, new| old + new }
h # => {:a=>1, :b=>5, :c=>4}

# Update user settings
defaults = {theme: "light", lang: "en"}
user = {theme: "dark"}
defaults.merge!(user)
defaults # => {:theme=>"dark", :lang=>"en"}
```

**Alias:** `update`