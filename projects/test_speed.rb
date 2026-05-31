#!/usr/bin/env ruby
# frozen_string_literal: true

# test_speed.rb — Benchmark.measure: how long does this really take?

# WITHOUT Benchmark — manual timing with Time.now subtraction:
#
#   start = Time.now
#   heavy_task
#   puts "Took #{Time.now - start}s"   # you do this every time
#
# WITH Benchmark — built-in, precise:

require 'benchmark'

def process_batch
  1_000_000.times { |i| i * i }
end

puts Benchmark.measure { process_batch }
