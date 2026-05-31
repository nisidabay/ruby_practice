#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — performance: benchmark, lazy, data structures

puts "=== 1. Benchmark two approaches ==="
require "benchmark"

n = 100_000
Benchmark.bm(15) do |x|
  x.report("for loop") do
    sum = 0
    for i in 1..n
      sum += i
    end
  end

  x.report("(1..n).sum") do
    (1..n).sum
  end
end

puts "\n=== 2. Lazy vs eager ==="
range = (1..1_000_000).lazy.map { |n| n * 2 }.select { |n| n % 5 == 0 }.first(5)
puts "Lazy: #{range.inspect}"

eager = (1..1_000_000).map { |n| n * 2 }.select { |n| n % 5 == 0 }.first(5)
puts "Eager same result: #{eager.inspect}"

puts "\n=== 3. Hash for fast lookups ==="
require "set"
keys = Array.new(50_000) { |i| "user_#{i}" }
map = keys.each_with_index.to_h { |k, i| [k, i] }
needle = "user_49999"
start = Time.now
val = map[needle]
elapsed = ((Time.now - start) * 1_000_000).round
puts "Hash[#{needle}] = #{val} in #{elapsed}µs"

# --- BONUS: Profile a real script with Benchmark.bmbm
# Compare two implementations of the same task (e.g., CSV read
# vs line-by-line parse) and report which is faster.
