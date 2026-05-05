#!/usr/bin/env ruby
# frozen_string_literal: true

# class_methods_class_block.rb — grouping class methods with class << self

class Vehicle
  attr_reader :wheels, :passengers

  def initialize(wheels, passengers)
    @wheels = wheels
    @passengers = passengers
  end

  class << self
    def car
      new(4, 6)
    end

    def truck
      new(18, 2)
    end
  end

  def to_s
    "Vehicle with #{wheels} wheels and #{passengers} passengers"
  end
end

puts Vehicle.new(2, 1)
puts Vehicle.car
puts Vehicle.truck

# Alternative: def self.car; new(4, 6); end

