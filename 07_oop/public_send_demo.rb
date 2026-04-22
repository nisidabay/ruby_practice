#!/usr/bin/env ruby
# frozen_string_literal: true

# ============================================
# public_send EXPLAINED SIMPLY
# ============================================

class Robot
  attr_accessor :arms, :eyes, :feet

  def initialize
    @arms = 'Robot Arms'
    @eyes = 'Camera Eyes'
    @feet = 'Metal Feet'
  end

  # A private method (not meant to be called from outside)
  private

  def secret_code
    'SECRET-123'
  end
end

robot = Robot.new

# ============================================
# Way 1: Regular method call (static)
# ============================================
puts "=== Regular Way (Static) ==="
puts "robot.arms: #{robot.arms}"
puts "robot.eyes: #{robot.eyes}"
puts "robot.feet: #{robot.feet}"

# Problem: You must know the method name at write-time!
# robot.send(:arms)  ← You write "arms" directly

# ============================================
# Way 2: Using public_send (dynamic)
# ============================================
puts "\n=== public_send Way (Dynamic) ==="

# You can store method names in variables!
method_name = :arms
puts "Using variable: robot.public_send(#{method_name}) = #{robot.public_send(method_name)}"

# You can loop through method names!
parts = %i[arms eyes feet]
parts.each do |part|
  puts "Looping: robot.public_send(#{part}) = #{robot.public_send(part)}"
end

# ============================================
# Key Differences:
# ============================================
puts "\n=== Key Differences ==="
puts "1. send()        → Can call ANY method (including private)"
puts "2. public_send() → Only calls PUBLIC methods (safer)"
puts ""

# send can call private methods:
begin
  result = robot.send(:secret_code)
  puts "send(:secret_code) works → #{result}"
rescue => e
  puts "send(:secret_code) failed"
end

# public_send CANNOT call private methods:
begin
  result = robot.public_send(:secret_code)
  puts "public_send(:secret_code) works → #{result}"
rescue => e
  puts "public_send(:secret_code) blocked! ✓ (#{e.message})"
end

# ============================================
# WHY use public_send in test.rb?
# ============================================
puts "\n=== Why test.rb uses public_send ==="
puts ""
puts "Instead of writing:"
puts "  puts 'Arms: ' + @arms.to_s if @arms"
puts "  puts 'Eyes: ' + @eyes.to_s if @eyes"
puts "  puts 'Feet: ' + @feet.to_s if @feet"
puts ""
puts "We can write:"
puts "  %i[arms eyes feet].each do |part|"
puts "    value = public_send(part)"
puts "    puts \"#{part.capitalize}: #{value || 'Not installed'}\""
puts "  end"
puts ""
puts "BENEFITS:"
puts "  ✓ Less code repetition"
puts "  ✓ Easy to add more parts (just add to the array)"
puts "  ✓ Dynamic - works with any method name"
puts "  ✓ Safer than send() - won't call private methods"