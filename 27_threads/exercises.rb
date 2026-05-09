#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Threads, Mutex, ConditionVariable

# --- Thread.new + join ---
t = Thread.new { sleep 0.1; puts "thread done" }
t.join

# --- Mutex#synchronize ---
mutex = Mutex.new
count = 0
threads = 3.times.map do
  Thread.new { 1000.times { mutex.synchronize { count += 1 } } }
end
threads.each(&:join)
puts "count = #{count}"   # => 3000

# --- BONUS: Write a method that takes an array of numbers and sums
#     them in parallel using 2 threads + a Mutex ---
