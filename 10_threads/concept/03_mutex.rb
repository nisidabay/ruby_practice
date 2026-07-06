#!/usr/bin/env ruby
# frozen_string_literal: true

# Mutex#synchronize wraps a block so only one thread
# enters it at a time. Fixes lost updates.

mutex   = Mutex.new
balance = 0

threads = 10.times.map do
  Thread.new do
    10_000.times do
      mutex.synchronize do
        tmp = balance
        Thread.pass       # still yields, but nobody can enter
        tmp += 1
        balance = tmp
      end
    end
  end
end

threads.each(&:join)
puts "Expected: 100_000  Got: #{balance}"

# Thinking in Ruby
#
# Mutex#synchronize creates a critical section — only one thread can enter
# the block at a time. This eliminates the data race from 02_data_race.rb.
# The Mutex is Ruby's lowest-level synchronization primitive, and it's all
# you need for most thread safety problems. The synchronize block ensures
# that read-modify-write happens atomically from any thread's perspective.
# Higher-level primitives like Queue and SizedQueue use Mutex internally.
