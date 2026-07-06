#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to capture a block as a named parameter so you can
#          pass it around, store it, or call it later (not just yield).
# Example: benchmark receives a block, times its execution, and returns
#          the block's result.
#
# Solution: Use &block in the parameter list to capture the block
#           as a Proc object.

def benchmark(label, &block)
  raise ArgumentError, 'No block was provided!' unless block

  start = Time.now
  result = block.call
  elapsed = Time.now - start
  puts "#{label}: #{elapsed}s"
  result
end

answer = benchmark('calculation') do
  sleep(0.1)
  42
end
puts "result: #{answer}"

# Thinking in Ruby
#
# Capturing a block as a Proc with &block elevates blocks from syntactic
# sugar to first-class objects. Unlike languages where callbacks require
# interfaces or function pointers, Ruby gives you a bare do...end that
# becomes a real object you can store, inspect, and invoke on your terms.
