#!/usr/bin/env ruby
# frozen_string_literal: true

# looping_numbers.rb — times, upto, downto, step

5.times { puts 'Test' }

1.upto(5) { |n| puts n }

10.downto(5) { |n| puts n }

0.step(50, 5) { |n| puts n }
