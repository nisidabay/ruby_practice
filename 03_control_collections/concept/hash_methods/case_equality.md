# === (Case Equality)

Returns `true` if the keys and values match. Used for case/when patterns.

```ruby
# Case equality
{a: 1} === {a: 1} # => true
{a: 1} === {a: 1, b: 2} # => false

# Used in case/when
h = {status: :ok}
case h
when {status: :ok} then "Success"
when {status: :error} then "Error"
end
# => "Success"

# Subset check isn't the default behavior
# === checks for full equality, not subset
{a: 1} === {a: 1, b: 2} # => false (not subset)

# With pattern matching (Ruby 2.7+)
case {name: "Alice", age: 30}
in {name:}
  puts name
end
# prints: Alice
```