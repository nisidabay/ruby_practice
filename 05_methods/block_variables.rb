#!/usr/bin/env ruby
# frozen_string_literal: true

# block_variables.rb — block parameters eliminate manual index arithmetic

# WITHOUT block params — manage the counter yourself:
#
#   3.times do
#     puts "Job #{$counter}"  # what counter? where? messy with globals
#   end
#
# WITH block params — Ruby hands you the index:

3.times { |i| puts "Worker #{i} starting..." }
