#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Pattern Matching practice

puts '=== Exercise 1: Value matching ==='
status = 404
case status
in 200 then puts 'Success'
in 404 then puts 'Not Found'
in 500 then puts 'Server Error'
else puts "Unknown: #{status}"
end

puts "\n=== Exercise 2: Array destructuring ==="
command = ['create', 'user', 'alice']
case command
in ['create', type, name]
  puts "Creating #{type} named '#{name}'"
in ['list', *filters]
  puts "Listing with: #{filters}"
end

puts "\n=== Exercise 3: Hash destructuring ==="
response = { status: 200, body: 'OK' }
case response
in { status: 200, body: msg }
  puts "Success: #{msg}"
in { status: code }
  puts "Status: #{code}"
end

puts "\n=== Exercise 4: Pin operator ==="
expected = 200
case response
in { status: ^expected, body: msg }
  puts "Expected #{expected}: #{msg}"
in { status: code }
  puts "Got #{code}, expected #{expected}"
end

puts "\n=== Exercise 5: Rightward assignment ==="
data = [1, 2, 3, 4, 5]
data => [first, *middle, last]
puts "First: #{first}, Middle: #{middle}, Last: #{last}"

puts "\n=== Exercise 6: Find pattern ==="
log = [:info, 'start', :error, 'timeout', :info, 'done']
case log
in [*, :error, msg, *]
  puts "Found error: #{msg}"
else
  puts 'No error found'
end
