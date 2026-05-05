#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to create methods that are called on the class itself, not instances.
# Example: Vehicle.car() returns a new Vehicle with 4 wheels and 6 passengers.
#
# Solution: Use def self.method_name to define class-level methods.
# Visibility: PUBLIC on the class only (not on instances).

class Vehicle
  attr_reader :wheels, :passengers, :type

  def initialize(wheels, passengers, type = 'vehicle')
    @wheels = validate_wheels(wheels)
    @passengers = passengers
    @type = type
  end

  def wheels=(wheels)
    @wheels = validate_wheels(wheels)
  end

  # Accept optional overrides
  def self.car(wheels: 4, passengers: 6)
    new(wheels, passengers)
  end

  def self.truck(wheels: 8, passengers: 2)
    new(wheels, passengers)
  end

  def to_s
    "Created new #{type} with #{wheels} wheels and #{passengers} passengers"
  end

  private

  def validate_wheels(wheels)
    raise ArgumentError, 'Wrong number of wheels!' unless wheels.is_a?(Integer) && wheels.between?(2, 12)

    wheels
  end
end

motorcycle = Vehicle.new(2, 1, 'motorcycle')
puts motorcycle

car = Vehicle.car
puts car

truck = Vehicle.truck
puts truck

# Now works correctly and consistently. Proper error handling!
# truck.wheels = 16
# puts truck
