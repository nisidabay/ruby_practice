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

# Thinking in Ruby
#
# Data races happen when multiple threads read and write the same variable
# without synchronization. The GIL (Global Interpreter Lock) in MRI does
# NOT prevent this — it only prevents two threads from running Ruby code
# at the exact same time, but thread switching can happen BETWEEN bytecode
# instructions. The read-modify-write sequence (tmp = balance; tmp += 1;
# balance = tmp) is NOT atomic. Thread.pass is used here to force the
# scheduler to switch threads, making the race condition reproducible.
