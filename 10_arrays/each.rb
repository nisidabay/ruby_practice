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
