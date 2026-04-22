# + (Plus / Union)

Returns a new hash combining entries from both hashes. Values from the right-hand hash take precedence for duplicate keys. Ruby 2.6+.

```ruby
h1 = {a: 1, b: 2}
h2 = {b: 3, c: 4}

# Merge two hashes
h1 + h2 # => {:a=>1, :b=>3, :c=>4}

# Original hashes unchanged
h1 # => {:a=>1, :b=>2}
h2 # => {:b=>3, :c=>4}

# Right-hand side wins for conflicts
{a: 1} + {a: 2} # => {:a=>2}

# Same as merge
({a: 1} + {b: 2}) == ({a: 1}.merge({b: 2})) # => true

# Multiple merges
h1 = {a: 1}
h2 = {b: 2}
h3 = {c: 3}
h1 + h2 + h3 # => {:a=>1, :b=>2, :c=>3}

# With different key types
{a: 1} + {"b" => 2} # => {:a=>"b"=>2...} (mixed keys)

# Works like merge, but syntax sugar for + operator
config = {theme: "light"}
defaults = {theme: "dark", lang: "en"}
config + defaults # => {:theme=>"dark", :lang=>"en"}
```

**Note:** Available in Ruby 2.6+