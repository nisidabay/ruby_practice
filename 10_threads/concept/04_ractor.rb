#!/usr/bin/env ruby
# frozen_string_literal: true

# Ractors run in true OS threads with isolated state.
# No GIL — they can run Ruby code truly in parallel.
# Communication is via send/receive (message-passing).

adder = Ractor.new do
  sum = 0
  loop do
    val = Ractor.receive       # block until message arrives
    break if val == :done
    sum += val
  end
  sum                          # becomes the return value
end

adder.send(10)
adder.send(20)
adder.send(30)
adder.send(:done)

puts adder.take                 # => 60
