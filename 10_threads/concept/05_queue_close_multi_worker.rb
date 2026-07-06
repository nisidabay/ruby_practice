#!/usr/bin/env ruby
# frozen_string_literal: true

# Queue#close + multiple consumers = the idiomatic Ruby
# worker pool. No manual shutdown signaling needed.

q = Queue.new

consumers = 3.times.map do |id|
  Thread.new do
    while (job = q.pop)
      sleep rand(0.02..0.06)          # simulate work
      puts "worker #{id} ran #{job}"
    end
  end
end

# Feed jobs.
8.times { |i| q << "job #{i}" }
q.close                               # consumers get nil, exit loop

consumers.each(&:join)
puts "all work done"

# Thinking in Ruby
#
# Queue#close + multiple consumers is the idiomatic Ruby worker pool
# pattern. #close signals all consumers that no more jobs are coming —
# each consumer's #pop returns nil, and the loop exits naturally. No
# sentinel values, no poison pills, no manual shutdown coordination.
# This is Ruby's philosophy of "make the common pattern simple" applied
# to concurrency: the Queue already handles thread safety, and #close
# handles clean shutdown. The result is elegant, readable, and correct.
