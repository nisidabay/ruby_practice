#!/usr/bin/env ruby
# frozen_string_literal: true
class Vehicle
  attr_reader :wheels, :passengers

  def initialize(wheels, passengers)
    @wheels = wheels
    @passengers = passengers
  end

  # class method - use as a helper method
  # Rubyish approach
  class << self
    def car
      new(4, 6)
    end
  end

  # def self.car
  #   new(4, 6)
  # end

  def self.truck
    new(18, 2)
  end

  def to_s
    "Created vehicle with #{wheels} wheels and #{passengers} passengers"
  end
end

motorcycle = Vehicle.new(2, 1)
p motorcycle.wheels
p motorcycle.passengers
p motorcycle.to_s

car = Vehicle.car
p car.wheels
p car.passengers
p car.to_s

truck = Vehicle.truck
p truck.wheels
p truck.passengers
p truck.to_s
