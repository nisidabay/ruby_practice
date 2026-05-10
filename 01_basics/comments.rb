#!/usr/bin/env ruby
# frozen_string_literal: true

# comments.rb — comments explain WHY, not what

balance = 500      # cents — integer avoids float rounding
balance -= 100     # subtract withdrawn amount
puts balance       # => 400
