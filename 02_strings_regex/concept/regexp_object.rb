#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Your pattern depends on user input or runtime data — you can't write a literal /.../.
# Example: A search tool where the user types terms to filter log lines.
# Solution: Regexp.new, Regexp.union, Regexp.escape — build patterns dynamically and safely.
# Visibility: Any time a pattern includes variable content.

# Dynamic regex from a string — user-provided search term
search_term = 'error'
pattern = Regexp.new(search_term, Regexp::IGNORECASE)
puts pattern.match?('FATAL ERROR') # => true

# Regexp.union — merge multiple strings into one alternation pattern
keywords = %w[error warn fatal]
combined = Regexp.union(keywords)
puts combined                                # => /error|warn|fatal/
puts combined.match?('warning')              # => true (matches "warn" inside "warning")

# Regexp.escape — sanitize user input so dots, stars, etc. match literally
user_input = 'config.*.yml'  # user searches for that literal string
safe = Regexp.escape(user_input)
puts safe                                   # => "config\.\*\.yml"
puts Regexp.new(safe).match?('config.prod.yml') # => true

# Interpolation in literal regex — clean inline alternative to Regexp.new
prefix = 'db_'
puts /#{prefix}\w+/.match?('db_master')     # => true

# Flags as Ruby constants: Regexp::IGNORECASE | Regexp::MULTILINE | Regexp::EXTENDED
pattern = Regexp.new('hello', Regexp::IGNORECASE | Regexp::MULTILINE)
puts pattern.match?("HELLO\nworld")         # => true

# This could also be done like this:
# Regexp.new("(?:#{user_input})") — but without escape, a user typing ".*"
# matches everything. Always escape user input before building a regex.

# Thinking in Ruby
#
# Regexp.new and Regexp.union build patterns dynamically from runtime data
# — critical when user input or configuration drives the search. Ruby's
# Regexp.escape sanitizes special characters, and the Regexp::CONSTANT
# flags compose with bitwise OR. Interpolation in literal /.../ also
# works, keeping dynamic patterns readable without leaving regex syntax.
