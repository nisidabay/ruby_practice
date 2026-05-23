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
