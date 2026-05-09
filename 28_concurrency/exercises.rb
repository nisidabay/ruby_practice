#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Queue, SizedQueue, Fiber, Ractor

# --- Queue (thread-safe FIFO) ---
q = Queue.new
Thread.new { q << "hello" }
puts q.pop               # => hello

# --- SizedQueue with backpressure ---
sq = SizedQueue.new(1)
sq << "full"             # queue is now full
# sq << "blocks"         # this would block forever — uncomment to see

# --- Fiber as a generator ---
fib = Fiber.new do
  Fiber.yield 1
  Fiber.yield 2
  nil
end
puts fib.resume          # => 1
puts fib.resume          # => 2

# --- BONUS: Write a Fiber that generates Fibonacci numbers on demand ---
