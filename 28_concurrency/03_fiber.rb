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
