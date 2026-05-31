# Strings & Regex — Practice Suite

String handling, interpolation, regex matching, and custom method exercises.

## Quick Start

```bash
# String fundamentals
ruby strings_literals.rb                # Multi-line strings and heredocs
ruby interpolation.rb                   # String interpolation with #{}
ruby split_chars.rb                     # Splitting into characters

# Regex
ruby matching.rb                        # =~ match operator
ruby regular_expressions.rb             # sub, gsub, scan — substitute and iterate
ruby ip_address.rb                       # Regex validation with boolean coercion
ruby exercises.rb                       # Regex: match, scan, substitute, capture

# String methods reference
ruby strings_methods.rb                 # Quick-lookup catalog (not a concept file)
```

## Learning Path

### String Fundamentals (~20 min)

| Script | Concept |
|---|---|
| `strings_literals.rb` | Multi-line strings, heredocs |
| `interpolation.rb` | `#{}` embeds code inside strings |
| `split_chars.rb` | Split a string into characters |
| `grapheme_clusters.rb` | `each_grapheme_cluster` — Unicode visual characters |

### Regex (~30 min)

| Script | Concept |
|---|---|
| `matching.rb` | `=~` returns match position or nil |
| `regular_expressions.rb` | `sub` (first), `gsub` (all), `scan` (iterate) |
| `ip_address.rb` | Regex validation + `!!` boolean coercion |

### Exercises

```bash
ruby exercises.rb                       # Core regex problems
ruby ex-sum-strings_1.rb                # Sum number strings
ruby ex-longest-word_2.rb               # Find longest word
ruby ex-custom_join_3.rb                # Custom join implementation
ruby ex-custom-split_4.rb              # Custom split implementation
ruby ex-custom-count_5.rb              # Count matching characters
ruby ex-custom-delete_6.rb              # Delete selected characters
ruby ex-custom-index_7.rb               # Find first index of substring
```

## Common Patterns

```ruby
# Interpolation
name = "Ruby"
puts "Hello, #{name}!"                  # Hello, Ruby!

# Match with =~
"hello" =~ /ell/                        # => 1 (position)
"hello" =~ /xyz/                        # => nil

# Substitute
"hello world".sub(/world/, "Ruby")      # => "hello Ruby" (first match)
"a a a".gsub(/a/, "b")                  # => "b b b"   (all matches)

# Scan
"a1 b2 c3".scan(/\w\d/)                 # => ["a1", "b2", "c3"]
```

## Now Build Your Own

Write a log parser that reads a file, extracts all lines matching
`ERROR` or `WARN`, and prints them with line numbers. Use `File.foreach`
and `=~` to do it without loading the whole file into memory.
