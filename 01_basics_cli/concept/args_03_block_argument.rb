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
  start = Time.now
  result = block.call
  elapsed = Time.now - start
  puts "#{label}: #{elapsed.round(4)}s"
  result
end

answer = benchmark('calculation') do
  sleep(0.1)
  42
end
puts "result: #{answer}"

# Without &block you'd need yield, but yield can't be stored or forwarded:
#
#   def benchmark(label)
#     start = Time.now
#     result = yield    # only option — can't pass it elsewhere
#     ...
#   end
