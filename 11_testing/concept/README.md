# Testing — Practice Suite

Minitest: assertions, setup/teardown, and algorithm practice problems.

## Quick Start

```bash
# Minitest fundamentals
ruby palindrome.rb                      # Palindrome checker with test
ruby reverse_string.rb                  # Reverse via negative indexing
ruby 02_assert_raises.rb                # Test that the RIGHT error is raised

# Advanced testing
ruby 03_assert_output.rb                # Test stdout/stderr output
ruby 04_setup_teardown.rb               # Shared state across test methods
ruby composition.rb                     # Composing test helpers

# Algorithm warmups
ruby guess_number.rb                    # rand, gets, loops, conditionals
ruby opendoors.rb                       # Range#step for skipping
ruby exercises.rb                       # FizzBuzz, palindrome, factorial
```

## Learning Path

### Minitest Basics (~30 min)

| Script | Concept |
|---|---|
| `palindrome.rb` | String equality after cleanup: `gsub` + `reverse` |
| `reverse_string.rb` | Negative indexing: `string[-1]`, `string[-2]`, ... |
| `guess_number.rb` | `rand`, `gets`, loops, and conditional branching |

### Assertions (~25 min)

| Script | Concept |
|---|---|
| `02_assert_raises.rb` | `assert_raises` — test that the RIGHT error is raised |
| `03_assert_output.rb` | `assert_output` — test stdout/stderr |
| `04_setup_teardown.rb` | `setup`/`teardown` — shared state across test methods |
| `composition.rb` | Composing test helpers via modules |
| `mock_demo.rb` | `Minitest::Mock` — verify calls without side effects |

### Algorithm Practice (~20 min)

| Script | Concept |
|---|---|
| `opendoors.rb` | `Range#step` — iterate every Nth element |
| `exercises.rb` | FizzBuzz, palindrome, factorial |

## Common Patterns

```ruby
require "minitest/autorun"

class PalindromeTest < Minitest::Test
  def test_racecar
    assert palindrome?("racecar")
  end

  def test_not_palindrome
    refute palindrome?("hello")
  end
end

# assert_raises
def test_divide_by_zero
  assert_raises(ZeroDivisionError) { 1 / 0 }
end

# assert_output
def test_greeting
  assert_output("Hello, World!\n") { puts "Hello, World!" }
end

# setup/teardown
class DatabaseTest < Minitest::Test
  def setup
    @db = Database.connect
    @db.create_table
  end

  def teardown
    @db.drop_table
    @db.disconnect
  end

  def test_insert
    @db.insert(name: "test")
    assert_equal 1, @db.count
  end
end
```

## Now Build Your Own

Write a test for a `PasswordValidator` class with methods `valid?` and
`errors`. Mock the `User#password` call with `Minitest::Mock` so you
can test validation without a real User object. Test at least 3 scenarios:
too short, no digits, and valid.
