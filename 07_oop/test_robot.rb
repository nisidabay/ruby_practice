#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'test'

puts "\n=== Edge Case Tests ===\n"

# Test 1: Custom initialization
puts "\nTest 1: Custom initialization"
custom_robot = Robot.new(head: 'LED Head', body: 'Metal body', legs: 'Wheels')
custom_robot.assemble!

# Test 2: Setting and getting all attributes
puts "\nTest 2: All attributes"
full_robot = Robot.new
full_robot.arms = 'Robot Arms'
full_robot.eyes = 'Camera Eyes'
full_robot.feet = 'Metal Feet'
full_robot.head = 'AI Head'
full_robot.body = 'Titanium Body'
full_robot.legs = 'Hydraulic Legs'
puts "All parts set:"
puts "  arms: #{full_robot.arms}"
puts "  eyes: #{full_robot.eyes}"
puts "  feet: #{full_robot.feet}"
puts "  head: #{full_robot.head}"
puts "  body: #{full_robot.body}"
puts "  legs: #{full_robot.legs}"

# Test 3: Nil values (not installed)
puts "\nTest 3: Nil values handling"
empty_robot = Robot.new
empty_robot.inspect_parts

# Test 4: Overwriting attributes
puts "\nTest 4: Overwriting attributes"
robot = Robot.new(head: 'Original Head')
puts "Before: #{robot.head}"
robot.head = 'Upgraded Head'
puts "After: #{robot.head}"

# Test 5: Boolean attribute check
puts "\nTest 5: Check object responds to methods"
robot = Robot.new
puts "responds to arms=: #{robot.respond_to?(:arms=)}"
puts "responds to eyes: #{robot.respond_to?(:eyes)}"
puts "responds to assemble!: #{robot.respond_to?(:assemble!)}"

puts "\n=== All tests completed ==="