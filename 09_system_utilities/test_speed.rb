#!/usr/bin/env ruby
# frozen_string_literal: true

# Test speed
# This file contains Ruby code for test speed.

require 'benchmark'

# A heavy task: calculating a big sum many times
def heavy_task
  1_000_000.times { |i| i * i }
end

puts 'Running benchmark...'
time = Benchmark.measure { heavy_task }
puts "Time taken: #{time.real.round(5)} seconds"
