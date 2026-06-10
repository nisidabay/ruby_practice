#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Thread practice

puts "=== Exercise 1: Thread basics ==="
def threaded_sum(arr)
  result = 0
  mutex = Mutex.new
  threads = arr.each_slice(arr.size / 4 + 1).map do |chunk|
    Thread.new do
      sum = chunk.sum
      mutex.synchronize { result += sum }
    end
  end
  threads.each(&:join)
  result
end
puts threaded_sum((1..100).to_a)

puts "
=== Exercise 2: Queue ==="
q = Queue.new
5.times { |i| q << i }
# HINT: q.pop until q.empty?

puts "\n=== Exercise 3: Threaded Port Scanner ==="
# Use a Queue to distribute 5 ports across 2 threads.
# Each thread pops a port, tries a connection, and prints the result.
require "socket"
ports = Queue.new
[80, 443, 22, 8080, 3000].each { |p| ports << p }
mu = Mutex.new

2.times.map do
  Thread.new do
    while !ports.empty?
      port = ports.pop(true) rescue nil
      next unless port
      # --- your code here ---
      # HINT: TCPSocket.new("127.0.0.1", port).close
      # HINT: mu.synchronize { puts "Port #{port}: OPEN" }
      # HINT: rescue Errno::ECONNREFUSED → "Port #{port}: CLOSED"
    end
  end
end.each(&:join)

puts "Scan complete."
