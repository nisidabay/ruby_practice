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
