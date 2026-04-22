#!/usr/bin/env ruby
# frozen_string_literal: true

# =============================================================================
# public_send - Dynamic Method Calling with Privacy Protection
# =============================================================================
#
# WHAT IT DOES:
#   Calls a method by name (symbol/string) but ONLY public methods.
#   Useful for dynamic/programmatic method invocation.
#
# COMPARISON:
#   send()         → Can call ANY method (public + private)
#   public_send()  → Can ONLY call public methods (respects encapsulation)
#
# WHY USE IT:
#   1. Dynamic method calls without verbose if/else chains
#   2. Security - prevents accidental/external access to private methods
#   3. Clean iteration over multiple attributes/methods
#
# EXAMPLE:
#   parts = %i[arms eyes feet]
#   parts.each { |part| robot.public_send(part) }
#   # Same as calling: robot.arms, robot.eyes, robot.feet
#
# =============================================================================

class Robot
  attr_accessor :arms, :eyes, :feet

  def initialize
    @arms = 'Robot Arms'
    @eyes = 'Camera Eyes'
    @feet = 'Metal Feet'
  end

  # Private method example
  private

  def secret_code
    'SECRET-123'
  end
end

robot = Robot.new

puts '=== Regular Method Call ==='
puts "robot.arms: #{robot.arms}"
puts "robot.eyes: #{robot.eyes}"

puts "\n=== Using public_send ==="
puts "robot.public_send(:arms): #{robot.public_send(:arms)}"
puts "robot.public_send(:eyes): #{robot.public_send(:eyes)}"

puts "\n=== Why use public_send? ==="
parts = %i[arms eyes feet] # This is an array of symbols

# WITHOUT public_send - Harder (need if/case statements)
puts "\nWithout public_send:"
parts.each do |part|
  if part == :arms
    puts "arms: #{robot.arms}"
  elsif part == :eyes
    puts "eyes: #{robot.eyes}"
  elsif part == :feet
    puts "feet: #{robot.feet}"
  end
end

# WITH public_send - Clean and dynamic!
puts "\nWith public_send (much cleaner):"
parts.each do |part|
  puts "#{part}: #{robot.public_send(part)}"
end

puts "\n=== public_send vs send ==="
puts 'send can call private methods:'
begin
  result = robot.send(:secret_code)
  puts "  send(:secret_code) = #{result} ✓ (works)"
rescue StandardError => e
  puts "  send(:secret_code) failed: #{e.message}"
end

puts "\npublic_send cannot call private methods:"
begin
  result = robot.public_send(:secret_code)
  puts "  public_send(:secret_code) = #{result}"
rescue StandardError => e
  puts "  public_send(:secret_code) failed: #{e.message} ✓ (protected)"
end

puts "\n=== In test.rb Context ==="
puts 'Original code:'
puts '  %i[arms eyes feet].each do |part|'
puts '    value = public_send(part)'
puts '    puts "#{part.capitalize}: #{value || \'Not installed\'}"'
puts '  end'
puts ''
puts 'This dynamically gets values for:'
puts '  - public_send(:arms) → robot.arms'
puts '  - public_send(:eyes) → robot.eyes'
puts '  - public_send(:feet) → robot.feet'
