#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to create methods that are called on the class itself, not instances.
# Example: Vehicle.car() returns a new Vehicle with 4 wheels and 6 passengers.
#
# Solution: Use def self.method_name to define class-level methods.
# Visibility: PUBLIC on the class only (not on instances).

class Vehicle
  attr_reader :wheels, :passengers

  def initialize(wheels, passengers)
    @wheels = wheels
    @passengers = passengers
  end

  # Class method using def self.method_name
  def self.car
    new(4, 6)
  end

  def self.truck
    new(18, 2)
  end

  def to_s
    "Created vehicle with #{wheels} wheels and #{passengers} passengers"
  end
end

# Usage: Call methods directly on the class
motorcycle = Vehicle.new(2, 1)
puts motorcycle.to_s

car = Vehicle.car
puts car.to_s

truck = Vehicle.truck
puts truck.to_s

# This could also be done like this:
# Using the class << self block syntax (see next file):
#
# class Vehicle
#   class << self
#     def car
#       new(4, 6)
#     end
#   end
# end
