#!/usr/bin/env ruby
# frozen_string_literal: true

# yield.rb — yield patterns: basic, args, return value, block_given?, sandwich

# 1. Basic: sandwich code (setup/teardown)
def wrapper
  puts 'Start'
  yield
  puts 'End'
end
wrapper { puts '>>> Block <<<' }

# 2. Passing arguments
def repeat(n)
  n.times { |i| yield(i) }
end
repeat(3) { |i| puts "Iteration #{i + 1}" }

# 3. Capturing return value
def transform(num)
  result = yield(num)
  puts "Original: #{num}, Transformed: #{result}"
  result
end
transform(10) { |n| n * n }   # => 100
transform(10) { |n| n + 5 }   # => 15

# 4. block_given? — make block optional
def maybe_yield
  puts 'Started'
  yield if block_given?
  puts 'Done'
end
maybe_yield { puts 'Block!' }
maybe_yield                     # no crash

# 5. Sandwich with ensure (always runs cleanup)
def with_timing
  start = Time.now
  puts 'Starting...'
  result = yield
  puts "Finished in #{(Time.now - start).round(2)}s"
  result
ensure
  puts 'Cleanup: timing complete'
end
with_timing { sleep(0.5); 42 }

# 6. &block vs yield: use &block when passing to another method
def internal(&block)
  block.call
end

def external(&)
  internal(&)  # pass block through
end
external { puts 'Passed through!' }

# Thinking in Ruby
#
# yield is Ruby's most fundamental block mechanism — it calls the block
# without naming it as a parameter. block_given? makes blocks optional,
# and the anonymous block parameter (&) in Ruby 3.0+ allows passing blocks
# through to nested calls without naming them. The sandwich method pattern
# (setup + yield + ensure/teardown) is Ruby's answer to resource management,
# predating and outlasting Python's with statement and Java's try-with-resources.

