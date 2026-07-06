#!/usr/bin/env ruby
# frozen_string_literal: true

# Threads run concurrently inside a single Ruby process.
# The main (calling) thread keeps going unless you #join.

threads = 3.times.map do |i|
  Thread.new(i) do |n|
    sleep rand(0.1..0.3)
    puts "Thread #{n} done"
  end
end

puts "Main thread is still running..."
threads.each(&:join)
puts "All threads finished."

# Thinking in Ruby
#
# Thread.new creates a concurrent execution context that runs alongside
# the main thread. Unlike Go's goroutines (managed by a runtime scheduler)
# or Python's asyncio (single-threaded cooperative), Ruby threads are OS
# threads managed by the GIL for MRI — they give you concurrency but not
# parallelism for Ruby code. Thread#join is how you synchronize: the main
# thread blocks until the joined thread finishes. Without join, the program
# exits when the main thread ends, killing all other threads.
