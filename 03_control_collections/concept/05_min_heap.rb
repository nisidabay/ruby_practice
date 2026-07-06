#!/usr/bin/env ruby
# frozen_string_literal: true

# 05_min_heap.rb — Min Heap: O(log n) push/pop, O(1) peek minimum
#
# WITHOUT a heap — find min = O(n) scan every time:
#
#   priorities.min  # scans entire array
#
# WITH heap — the minimum is always at index 0, O(1) access:

class MinHeap
  def initialize; @heap = []; end

  def push(value)
    @heap << value
    sift_up(@heap.size - 1)
  end

  def pop
    return nil if @heap.empty?
    min = @heap[0]
    @heap[0] = @heap.pop
    sift_down(0) unless @heap.empty?
    min
  end

  def peek; @heap[0]; end

  private

  def sift_up(i)
    parent = (i - 1) / 2
    return if i <= 0 || @heap[parent] <= @heap[i]
    @heap[parent], @heap[i] = @heap[i], @heap[parent]
    sift_up(parent)
  end

  def sift_down(i)
    left, right = i * 2 + 1, i * 2 + 2
    smallest = i
    smallest = left if left < @heap.size && @heap[left] < @heap[smallest]
    smallest = right if right < @heap.size && @heap[right] < @heap[smallest]
    return if smallest == i
    @heap[i], @heap[smallest] = @heap[smallest], @heap[i]
    sift_down(smallest)
  end
end

tasks = MinHeap.new
[5, 3, 8, 1, 2].each { |v| tasks.push(v) }
puts tasks.pop  # => 1 (highest priority = smallest number)
puts tasks.pop  # => 2
puts tasks.peek # => 3 (next to go, without removing)

# Thinking in Ruby
#
# The min heap is implemented with array-based sift-up/sift-down — Ruby's
# dynamic arrays and parallel assignment (a, b = b, a) make the swap
# operations concise. The heap property (parent <= children) is maintained
# with recursive methods that read as natural definitions of the algorithm.
