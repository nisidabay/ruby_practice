#!/usr/bin/env ruby
# frozen_string_literal: true

# each.rb — iterate without index management

# WITHOUT each — manual counter:
#
#   endpoints = %w[/api/v1 /api/v2 /admin]
#   i = 0
#   while i < endpoints.length
#     puts "GET #{endpoints[i]}"
#     i += 1
#   end
#
# WITH each — Ruby walks the array for you:

%w[/api/v1 /api/v2 /admin].each do |path|
  puts "GET #{path}"
end

# Thinking in Ruby
#
# .each is the foundational Enumerable method. Implement it, include
# Enumerable, and get 50+ methods free. Unlike indexed loops, .each
# abstracts away the data structure — same syntax for Array, Hash, Range,
# or custom collections. This is the heart of Ruby's collection
# philosophy.
