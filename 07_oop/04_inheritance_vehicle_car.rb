#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want a child class to inherit and specialize behavior from a parent class.
# Example: A Car is a Vehicle - it should move like a vehicle but with car-specific details.
#
# Solution: Use inheritance with the < symbol to derive from a parent class.
# Visibility: Child has access to parent's public/protected methods, can override them.

class Vehicle
  attr_reader :brand

  def initialize(brand)
    @brand = brand
  end

  def move
    "The #{@brand} is moving."
  end
end

# Car "is-a" Vehicle
class Car < Vehicle
  def move
    "#{super} It rolls on four wheels."
  end
end

# Usage: Create child class instances, they inherit parent behavior
my_car = Car.new("Toyota")
puts my_car.move

# This could also be done like this:
# If you need multiple inheritance-like behavior, use modules with include:
#
# module Drivable
#   def move
#     "Moving..."
#   end
# end
#
# class Car
#   include Drivable
# end
