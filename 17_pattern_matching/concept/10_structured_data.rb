#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Parse real-world structured data — nested hashes, mixed arrays, optional keys.
# Example: An API response that might be success, error, or paginated — different shapes.
#
# Solution: Combine hash patterns, array patterns, guards, and alternatives.
# Visibility: This is where pattern matching shines — one case/in handles all shapes.

# Simulated API responses — three different shapes:
responses = [
  { status: 200, data: { users: [{ name: 'Alice' }, { name: 'Bob' }] } },
  { status: 404, error: 'Not Found', code: 'USR_404' },
  { status: 200, data: { users: [{ name: 'Carol' }] }, meta: { page: 2, total: 50 } }
]

responses.each do |response|
  case response
  # Success with pagination
  in { status: 200, data: { users: users }, meta: { page: page, total: total } }
    puts "Page #{page}/#{total}: #{users.map { |u| u[:name] }}"

  # Success without pagination
  in { status: 200, data: { users: users } }
    puts "Users: #{users.map { |u| u[:name] }}"

  # Error response
  in { status: code, error: msg, code: err_code } if code >= 400
    puts "Error #{code} (#{err_code}): #{msg}"

  # Unknown
  else
    puts "Unexpected response shape"
  end
end
# Output:
#   Users: ["Alice", "Bob"]
#   Error 404 (USR_404): Not Found
#   Page 2/50: ["Carol"]

# This could also be done like this:
# Without pattern matching — nested if/else with fetch and nil checks:
#
#   if response[:status] == 200
#     users = response.dig(:data, :users)
#     if response.key?(:meta)
#       page = response[:meta][:page]
#       total = response[:meta][:total]
#       puts "Page #{page}/#{total}: #{users.map { |u| u[:name] }}"
#     else
#       puts "Users: #{users.map { |u| u[:name] }}"
#     end
#   elsif response[:status] && response[:status] >= 400
#     puts "Error #{response[:status]} (#{response[:code]}): #{response[:error]}"
#   end
#
# Pattern matching handles all shapes in one flat structure — no nesting.

# Thinking in Ruby
#
# Pattern matching transforms nested if/else trees into a flat, readable
# case/in block. Each response shape gets its own branch with inline
# destructuring: status, data, meta, and error all extracted in the
# pattern itself. Ruby's pattern matching is the anti-telephone-game
# for data — what you see is what you match, and what you match is
# what you get.
