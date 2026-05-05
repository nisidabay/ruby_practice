#!/usr/bin/env ruby
# frozen_string_literal: true

# block_variables.rb — block parameters

def increment_of_two
  6.times { |count| print count * 2 }
end

increment_of_two  # => 0 2 4 6 8 10
puts
