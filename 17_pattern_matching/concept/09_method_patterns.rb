#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Use pattern matching directly in method bodies for clean dispatching.
# Example: A `handle` method that does different things based on input shape.
#
# Solution: Endless methods + case/in, or case/in as the method body.
# Visibility: Same as any method — the pattern matching is just the implementation.

# Endless method with pattern matching (Ruby 3.0+):
def classify(status) = case status
                       in 200 | 201 then 'Success'
                       in 300..399  then 'Redirect'
                       in 400..499  then 'Client Error'
                       in 500..599  then 'Server Error'
                       else "Unknown (#{status})"
                       end

puts classify(200)  # => Success
puts classify(404)  # => Client Error
puts classify(999)  # => Unknown (999)

# Usage: Destructuring in method args with rightward assignment
def process(response)
  response => { status: code, body: msg }
  "#{code}: #{msg}"
end

puts process({ status: 200, body: 'OK' })  # => 200: OK

# Usage: Multi-shape dispatch
def parse(input)
  case input
  in [action, *args] then "Command: #{action}(#{args})"
  in { error: msg }  then "Error: #{msg}"
  in String          then "Text: #{input}"
  else "Unknown type"
  end
end

puts parse(['create', 'user'])  # => Command: create(["user"])
puts parse({ error: 'timeout' })  # => Error: timeout
puts parse('hello')               # => Text: hello

# This could also be done like this:
# Traditional if/elsif dispatch (more verbose):
#
#   def parse(input)
#     if input.is_a?(Array)
#       "Command: #{input[0]}(#{input[1..]})"
#     elsif input.is_a?(Hash) && input.key?(:error)
#       "Error: #{input[:error]}"
#     elsif input.is_a?(String)
#       "Text: #{input}"
#     end
#   end
