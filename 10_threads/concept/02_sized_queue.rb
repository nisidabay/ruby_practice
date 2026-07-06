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

# Thinking in Ruby
#
# SizedQueue adds backpressure to the producer-consumer pattern. The max
# capacity means #push blocks when the queue is full — the producer can't
# outrun the consumer. This prevents unbounded memory growth (the queue
# can't grow larger than its capacity) and naturally balances production
# and consumption rates. SizedQueue is Queue's more predictable sibling
# for real-world work distribution where downstream capacity is limited.
