#!/usr/bin/env ruby
# frozen_string_literal: true

# Queue is a thread-safe FIFO. #pop blocks when empty;
# #push adds items. No Mutex needed — it's built in.

q = Queue.new

producer = Thread.new do
  5.times do |i|
    q << "item #{i}"
    puts "pushed item #{i}"
    sleep 0.05
  end
  q.close                    # signals "no more items coming"
end

consumer = Thread.new do
  while (item = q.pop)       # #pop returns nil when queue is closed
    puts "popped #{item}"
  end
end

producer.join
consumer.join
