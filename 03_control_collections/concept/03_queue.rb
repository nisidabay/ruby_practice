#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_queue.rb — Queue (FIFO): enqueue (push) + dequeue (shift)
#
# WITHOUT a proper queue — Array#shift is O(n):
#
#   queue.shift  # removes first element, shifts every other element left
#
# WITH Queue — Ruby's Queue class from 'thread' is thread-safe, O(1) amortized.
# For learning: array-backed with shift is fine for small sizes.

class SimpleQueue
  def initialize; @q = []; end
  def enqueue(v); @q << v; end
  def dequeue;    @q.shift; end
  def front;      @q.first; end
  def empty?;     @q.empty?; end
end

line = SimpleQueue.new
line.enqueue("Ana")
line.enqueue("Luis")
line.enqueue("Maria")
puts line.dequeue  # => "Ana"    (first in, first out)
puts line.dequeue  # => "Luis"
puts line.front    # => "Maria"  (next to go)

# Thinking in Ruby
#
# Ruby's stdlib Queue class (from 'thread') is thread-safe and provides
# O(1) amortized enqueue/dequeue. For learning, a simple array-backed
# queue with shift works — but Ruby's built-in Queue is a reminder that
# the language ships solutions for concurrency patterns too.
