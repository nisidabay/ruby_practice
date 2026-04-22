# dig

Extracts a nested value by traversing keys. Returns `nil` if any intermediate key is missing (no error).

```ruby
h = {a: {b: {c: 3}}}

# Deep access
h.dig(:a, :b, :c) # => 3

# Missing intermediate key returns nil
h.dig(:a, :x, :c) # => nil

# Works with arrays inside
h = {users: [{name: "Alice"}, {name: "Bob"}]}
h.dig(:users, 0, :name) # => "Alice"
h.dig(:users, 2, :name) # => nil (index out of range)

# Compare with chained access
h[:a][:b][:c] # => 3
h[:a][:x][:c] # NoMethodError: undefined method '[]' for nil:NilClass
h.dig(:a, :x, :c) # => nil (safe)

# Works on nested structures
config = {
  database: {
    primary: {
      host: "localhost",
      port: 5432
    }
  }
}
config.dig(:database, :primary, :host) # => "localhost"
```