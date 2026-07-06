#!/usr/bin/env ruby
# frozen_string_literal: true

# 01_array_stack.rb — Stack (LIFO) backed by Array: push/pop, O(1)
#
# WITHOUT push/pop — manual index tracking:
#
#   @data[@top] = value; @top += 1  # push
#   @top -= 1; @data[@top]          # pop
#
# WITH Array — Ruby's array methods are already O(1) amortized:

class Stack
  def initialize; @stack = []; end
  def push(v);    @stack << v; end
  def pop;        @stack.pop; end
  def top;        @stack.last; end
  def empty?;     @stack.empty?; end
end

undo = Stack.new
undo.push("typed 'hello'")
undo.push("typed 'world'")
undo.push("applied bold")
puts undo.pop  # => "applied bold" (undo last action)
puts undo.pop  # => "typed 'world'"
puts undo.top  # => "typed 'hello'" (peek without removing)

# Thinking in Ruby
#
# Ruby's Array already provides O(1) push/pop — the Stack class is a
# wrapper that restricts the API while leveraging the underlying
# performance. This is Ruby's "wrap, don't rewrite" approach: standard
# data structures are performant enough; add types for intent, not speed.
