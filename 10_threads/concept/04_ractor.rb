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

# Thinking in Ruby
#
# Ractor (Ruby 3.0+) introduces true parallelism with isolated state.
# Unlike threads (which share all memory and need mutexes), each Ractor
# has its own execution context and communicates via message passing
# (send/receive). Ractors bypass the GIL entirely, enabling true parallel
# execution on multi-core CPUs. The trade-off: you can't share mutable
# objects between Ractors — you must copy or move them. This is Ruby's
# answer to the "freeze or copy" concurrency model, inspired by CSP
# (Communicating Sequential Processes) from Go and Erlang.
