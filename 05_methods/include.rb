#!/usr/bin/env ruby
# Include
# This file contains Ruby code for include.

#!/usr/sbin/ruby
# frozen_string_literal: true

puts 'Big Mac'.include?('B')
puts 'Big Mac'.include?('Bi')
puts 'Big Mac'.include?('M')
puts 'Big Mac'.include?('z')
puts 'Big Mac'.include?('b')

# These lines give error
# puts 'Big Mac'.include?
# puts 'Big Mac'.include? 'A', 'B'
