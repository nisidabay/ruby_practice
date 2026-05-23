#!/usr/bin/env ruby
# frozen_string_literal: true

# predicate_methods.rb — boolean queries: odd?/even?/positive?/negative?

# WITHOUT predicate methods — write comparisons by hand:
#
#   status = 500
#   puts "Server error" if status >= 500 && status < 600
#   # every range check is two comparisons
#
# WITH predicate methods — one word:

p 404.even?       # => true  (client error range starts at 400)
p 301.odd?        # => true  (redirect range starts at 300)
p 200.positive?   # => true  (success response)
p (-1).negative?  # => true  (exit code -1 means error)
p 0.zero?         # => true  (exit 0 = success)
