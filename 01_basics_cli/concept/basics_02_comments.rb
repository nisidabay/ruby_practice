#!/usr/bin/env ruby
# frozen_string_literal: true

# comments.rb — comments explain WHY, not what

balance = 500      # cents — integer avoids float rounding
balance -= 100     # subtract withdrawn amount
puts balance       # => 400

# Thinking in Ruby
#
# Ruby comments document WHY, not what. Unlike languages with block comments
# as an afterthought, Ruby treats # as a deliberate guide — use it to explain
# units, invariants, or business rules that the code itself cannot express.
