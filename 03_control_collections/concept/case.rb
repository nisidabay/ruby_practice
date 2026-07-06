#!/usr/bin/env ruby
# frozen_string_literal: true

# case.rb — cleaner than if/elsif when you're matching one value against patterns

# WITHOUT case — repeated == calls or .is_a? chains:
#
#   def handle(response)
#     if response.is_a?(Hash)       then "JSON payload: #{response.keys}"
#     elsif response.is_a?(String)  then "Plain text: #{response[0..40]}..."
#     elsif response.is_a?(Integer) then "Status code: #{response}"
#     else "Unknown response type"
#     end
#   end
#
# WITH case — the comparison is implicit, no .is_a? noise:

def handle(response)
  case response
  when Hash    then "JSON payload: #{response.keys}"
  when String  then "Plain text: #{response[0..40]}..."
  when Integer then "Status code: #{response}"
  else "Unknown response type"
  end
end

puts handle({user: "carlos", role: "admin"})
puts handle("Error: connection refused (timeout after 30s...)")
puts handle(404)

# Thinking in Ruby
#
# Ruby's case/when uses === (the case equality operator) under the hood,
# which means you can match against classes, regexes, ranges, or lambdas
# — not just literal values. This makes case far more expressive than
# switch statements in C-family languages, and it returns a value like
# any Ruby expression.
