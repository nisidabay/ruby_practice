#!/usr/bin/env ruby
# frozen_string_literal: true

# Fibers are cooperative. You control exactly when they
# yield and resume — no scheduler, no preemption.

counter = Fiber.new do
  n = 0
  loop do
    Fiber.yield n           # hand back n, pause here
    n += 1                  # runs on next #resume
  end
end

5.times { puts counter.resume }   # 0 1 2 3 4

# Fibers are useful for generators:
words = Fiber.new do
  Fiber.yield "hello"
  Fiber.yield "world"
  nil
end

puts words.resume     # "hello"
puts words.resume     # "world"
puts words.resume.inspect   # nil

# Thinking in Ruby
#
# Fibers are Ruby's take on cooperative concurrency — they yield explicitly
# and resume explicitly, with no OS scheduler involved. Unlike threads,
# fibers don't run in parallel and don't need mutexes; only one fiber runs
# at a time, and it yields control at known points. They're perfect for
# generators, lazy enumerators, and async-await patterns (via Fiber.scheduler
# in Ruby 3.0+). Think of fibers as "pausable methods" rather than threads.
