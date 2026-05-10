#!/usr/bin/env ruby
# frozen_string_literal: true

# times.rb — repeat without a while loop

# WITHOUT #times — explicit counter:
#
#   i = 0
#   while i < 5
#     puts "Ping #{i + 1}..."
#     i += 1
#   end
#
# WITH #times — Ruby handles the counter:

5.times { |i| puts "Ping #{i + 1}..." }
