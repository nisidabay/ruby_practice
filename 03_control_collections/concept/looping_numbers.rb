#!/usr/bin/env ruby
# frozen_string_literal: true

# looping_numbers.rb — times, upto, downto, step

5.times { puts 'Test' }

1.upto(5) { |n| puts n }

10.downto(5) { |n| puts n }

0.step(50, 5) { |n| puts n }

# Thinking in Ruby
#
# times, upto, downto, and step are integer iteration methods that read
# like English: "5 times", "1 up to 5", "10 down to 5", "0 step 50 by
# 5". They're methods on Integer, each accepting a block. This is Ruby's
# "tell, don't ask" philosophy applied to iteration itself.
