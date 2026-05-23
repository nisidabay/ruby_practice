#!/usr/bin/env ruby
class Engine
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def to_s
    "#{type}"
  end
end

class Car
  attr_accessor :model, :engine

  def initialize(model, engine)
    @model = model
    @engine = engine
  end

  def to_s
    "New car: #{@model}. Engine: #{@engine}"
  end
end

# Demonstrate composition
engine = Engine.new('V8')
car = Car.new('Toyota', engine)

puts car

# Change the engine to demonstrate flexibility
engine.type = 'Electric'
puts car

# Create a new car with a different engine
engine2 = Engine.new('V6')
car2 = Car.new('Honda', engine2)
puts car2
