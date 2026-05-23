# <=> (Spaceship)

Compares two hashes. Returns -1, 0, or 1 based on comparison rules.

```ruby
# Equal hashes
{a: 1} <=> {a: 1} # => 0

# Compare sizes first (shorter is smaller)
{a: 1} <=> {a: 1, b: 2} # => -1
{a: 1, b: 2} <=> {a: 1} # => 1

# Same size: compare keys first
{a: 1, b: 2} <=> {b: 1, a: 2} # => -1 (:a < :b)

# Same keys: compare values
{a: 1} <=> {a: 2} # => -1
{a: 2} <=> {a: 1} # => 1
{a: 1} <=> {a: 1} # => 0

# Useful for sorting array of hashes
hashes = [{b: 2}, {a: 1}, {c: 3}]
hashes.sort # => [{:a=>1}, {:b=>2}, {:c=>3}]

# Complex comparison
{a: 1, b: 2} <=> {a: 1, b: 3} # => -1
{a: 2, b: 1} <=> {a: 1, b: 2} # => 1

# Not directly comparable types
{a: 1} <=> [[:a, 1]] # => nil

# Nil indicates comparison not possible
nil <=> {a: 1} # => nil
```