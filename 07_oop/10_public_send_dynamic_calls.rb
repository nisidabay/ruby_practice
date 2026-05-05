#!/usr/bin/env ruby
# frozen_string_literal: true

# public_send_dynamic_calls.rb — call methods by symbol, safer than send

class Robot
  attr_accessor :arms, :eyes, :feet

  def initialize
    @arms = 'Robot Arms'
    @eyes = 'Camera Eyes'
    @feet = 'Metal Feet'
  end

  private

  def secret_code
    'SECRET-123'
  end
end

robot = Robot.new

# Static calls
puts robot.arms, robot.eyes

# Dynamic calls
%i[arms eyes feet].each { |part| puts "#{part}: #{robot.public_send(part)}" }

# public_send blocks private methods (unlike send)
robot.send(:secret_code)       # works, but bypasses encapsulation
begin
  robot.public_send(:secret_code) # raises NoMethodError
rescue NoMethodError
  puts "public_send blocked private method ✓"
end

