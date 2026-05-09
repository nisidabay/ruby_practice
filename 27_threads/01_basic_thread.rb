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
