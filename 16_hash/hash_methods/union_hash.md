# | (Pipe / Union)

Returns a new hash combining entries from both hashes. Values from the right-hand hash take precedence for duplicate keys. Ruby 2.6+.

```ruby
h1 = {a: 1, b: 2}
h2 = {b: 3, c: 4}

# Merge two hashes
h1 | h2 # => {:a=>1, :b=>3, :c=>4}

# Original hashes unchanged
h1 # => {:a=>1, :b=>2}
h2 # => {:b=>3, :c=>4}

# Right-hand side wins for conflicts
{a: 1} | {a: 2} # => {:a=>2}

# Same as merge and +
(h1 | h2) == (h1.merge(h2)) # => true
(h1 | h2) == (h1 + h2) # => true

# Multiple merges
{a: 1} | {b: 2} | {c: 3} # => {:a=>1, :b=>2, :c=>3}

# Combine configuration layers
defaults = {theme: "light", lang: "en"}
user_prefs = {theme: "dark"}
final = defaults | user_prefs # => {:theme=>"dark", :lang=>"en"}

# Works like merge for union semantics
# Note: unlike arrays, duplicates have right override (not left)
{a: 1} | {a: 2} # => {:a=>2} (right wins)
```

**Note:** Available in Ruby 2.6+