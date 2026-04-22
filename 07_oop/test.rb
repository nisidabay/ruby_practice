#!/usr/bin/env ruby
# frozen_string_literal: true

# Test
# This file contains Ruby code for test.

class Robot
  # Use accessor to allow both reading and writing
  attr_accessor :arms, :eyes, :feet, :head, :body, :legs

  def initialize(head: 'Oval head', body: 'Plastic body', legs: 'Walking legs')
    @head = head
    @body = body
    @legs = legs
  end

  def assemble!
    puts "Default setup\n-------------"
    puts "Head: #{@head}\nBody: #{@body}\nLegs: #{@legs}"
  end

  def inspect_parts
    # ============================================
    # Why use public_send() instead of @arms, @eyes, etc?
    # ============================================
    #
    # WITHOUT public_send (static - must know names at write-time):
    #   puts "Arms: #{@arms || 'Not installed'}"
    #   puts "Eyes: #{@eyes || 'Not installed'}"
    #   puts "Feet: #{@feet || 'Not installed'}"
    #
    # WITH public_send (dynamic - can loop through method names):
    #   %i[arms eyes feet].each do |part|
    #     value = public_send(part)
    #     puts "#{part.capitalize}: #{value || 'Not installed'}"
    #   end
    #
    # Benefits:
    #   ✓ Less repetition - one loop handles all parts
    #   ✓ Easy to extend - just add to the array
    #   ✓ Dynamic - works with any method name in a variable
    #   ✓ Safer than send() - only calls public methods
    #
    # Comparison:
    #   send()        → Calls ANY method (including private)
    #   public_send() → Only calls PUBLIC methods (safer!)
    # ============================================

    %i[arms eyes feet].each do |part|
      value = public_send(part) # public_send(:arms) → calls self.arms
      puts "#{part.capitalize}: #{value || 'Not installed'}"
    end
  end
end

# Usage
robot = Robot.new
robot.assemble!

robot.eyes = 'X-Ray Scopes'
robot.inspect_parts
