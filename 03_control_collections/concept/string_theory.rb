#!/usr/bin/env ruby
# frozen_string_literal: true

# string_theory.rb — predicates with ||

def string_theory(value)
  value.include?('B') || value.length > 4
end

puts string_theory('Big Mac')     # => true (has B)
puts string_theory('Bank')        # => true (has B)
puts string_theory('refrigerator') # => true (length > 4)
puts string_theory('boy')         # => false (no B, length 3)
puts string_theory('car')         # => false (no B, length 3)

# Thinking in Ruby
#
# Ruby's predicate methods (include?, length, etc.) return booleans
# naturally, composing with && and || in conditions. The trailing if
# modifier and compound boolean expressions let you write concise guard
# clauses without sacrificing readability — a practical duality of
# Ruby's expression-oriented design.
