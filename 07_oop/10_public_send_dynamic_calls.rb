#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to call methods dynamically by name without using if/else chains.
# Example: Loop through [:arms, :eyes, :feet] and call robot.arms, robot.eyes, robot.feet.
#
# Solution: Use public_send(method_name) to call methods by symbol/string dynamically.
# Visibility: Only calls PUBLIC methods (safer than send which calls private too).

class Robot
  attr_accessor :arms, :eyes, :feet

  def initialize
    @arms = 'Robot Arms'
    @eyes = 'Camera Eyes'
    @feet = 'Metal Feet'
  end
end

robot = Robot.new

# Static way - must know method names at write time
puts "=== Static Method Calls ==="
puts "robot.arms: #{robot.arms}"
puts "robot.eyes: #{robot.eyes}"

# Dynamic way - method names in variables/arrays
puts "\n=== Dynamic Method Calls with public_send ==="
method_name = :arms
puts "Using variable: robot.public_send(:#{method_name}) = #{robot.public_send(method_name)}"

parts = %i[arms eyes feet]
parts.each do |part|
  puts "Looping: robot.public_send(:#{part}) = #{robot.public_send(part)}"
end

# Safety: public_send vs send
puts "\n=== Safety Comparison ==="
class Robot
  private

  def secret_code
    'SECRET-123'
  end
end

robot = Robot.new
begin
  result = robot.send(:secret_code)
  puts "send(:secret_code) works → #{result}"
rescue => e
  puts "send(:secret_code) failed"
end

begin
  result = robot.public_send(:secret_code)
  puts "public_send(:secret_code) works → #{result}"
rescue => e
  puts "public_send(:secret_code) blocked! ✓ (private method protected)"
end

# This could also be done like this:
# For simple cases with known methods, just call them directly:
#
# parts.each do |part|
#   case part
#   when :arms then puts robot.arms
#   when :eyes then puts robot.eyes
#   when :feet then puts robot.feet
#   end
# end
