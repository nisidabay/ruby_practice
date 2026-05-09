#!/usr/bin/env ruby
# frozen_string_literal: true

# SizedQueue has a max capacity. #push blocks when full,
# #pop blocks when empty. Natural backpressure.

q = SizedQueue.new(2)     # only 2 items at a time

producer = Thread.new do
  5.times do |i|
    q << "item #{i}"      # blocks if q is full
    puts "pushed item #{i}"
  end
  q.close
end

consumer = Thread.new do
  sleep 0.1               # let producer fill the queue first
  while (item = q.pop)
    puts "        popped #{item}"
    sleep 0.15
  end
end

producer.join
consumer.join
