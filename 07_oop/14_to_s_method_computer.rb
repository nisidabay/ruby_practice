#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to customize how an object looks when printed with puts.
# Example: puts computer should show "A powerful Intel i7 computer with 64GB memory..."
#
# Solution: Define a to_s instance method that returns a custom string.
# Visibility: PUBLIC - Ruby calls to_s automatically with puts/print.

class Computer
  def initialize
    @cpu = 'Intel i7'
    @memory = 64
    @storage = '2 TB'
  end

  def to_s
    "A powerful #{@cpu} computer with #{@memory}GB memory and #{@storage} of storage"
  end
end

# Usage: puts automatically calls to_s
computer = Computer.new
puts computer

# Explicit call also works:
puts computer.to_s

# This could also be done like this:
# For developer debugging, use inspect instead:
#
# class Computer
#   def inspect
#     "#<Computer cpu=#{@cpu} memory=#{@memory}GB>"
#   end
# end
#
# p computer  # Calls inspect, not to_s
