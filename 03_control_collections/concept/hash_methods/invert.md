# invert

Returns a new hash with keys and values swapped. Values become keys, keys become values.

```ruby
h = {a: 1, b: 2, c: 3}

# Invert keys and values
h.invert # => {1=>:a, 2=>:b, 3=>:c}

# Original unchanged
h # => {:a=>1, :b=>2, :c=>3}

# Duplicate values: last one wins
h = {a: 1, b: 1, c: 1}
h.invert # => {1=>:c} (only one entry: last key wins)

# Value order matters for duplicates
h = {a: "x", b: "x", c: "y", d: "x"}
h.invert # => {"x"=>:d, "y"=>:c}

# Invert back
inverted = {1=>:a, 2=>:b}
inverted.invert # => {:a=>1, :b=>2}

# Useful for reverse lookup
codes = {us: "United States", uk: "United Kingdom"}
codes.invert # => {"United States"=>:us, "United Kingdom"=>:uk}
```