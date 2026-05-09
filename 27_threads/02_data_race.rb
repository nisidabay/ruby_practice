#!/usr/bin/env ruby
# frozen_string_literal: true

# When 2+ threads mutate shared state without a lock,
# lost updates happen. The GIL doesn't save you.

balance = 0

threads = 10.times.map do
  Thread.new do
    10_000.times do
      tmp = balance
      # Thread.pass forces the scheduler to consider switching
      # to another thread RIGHT HERE — between read and write.
      Thread.pass
      tmp += 1
      balance = tmp
    end
  end
end

threads.each(&:join)
puts "Expected: 100_000  Got: #{balance}"
