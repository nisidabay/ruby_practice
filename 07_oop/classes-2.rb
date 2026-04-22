#!/usr/bin/env ruby
# frozen_string_literal: true

# Object-Oriented Programming Examples
# This file demonstrates Ruby OOP concepts including:
# - Encapsulation (custom setters with validation)
# - Inheritance (subclassing and super calls)
# - Polymorphism (method overriding)

# =============================================================================
# ENCAPSULATION EXAMPLE
# =============================================================================

# Demonstrates a class with custom setters that validate data (encapsulation).

class Dog
  attr_reader :name, :age # provides read-only access; custom setters below handle validation

  def name=(value)
    raise "Name can't be blank!" if value.empty? # Ensure name is not empty

    @name = value
  end

  def age=(value)
    raise "An age of #{value} isn't valid" unless value.is_a?(Integer) && (value > 0) # Age must be positive integer

    @age = value
  end

  def report
    puts "#{name} is #{age} old" # Simple report method
  end
end

dog = Dog.new
dog.name = 'Pepe'
dog.age = 2
dog.report
# dog.name = '' # THIS WILL FAILED
# dog.age = -1 # ALSO THIS

# =============================================================================
# INHERITANCE EXAMPLE
# =============================================================================

# Base class (superclass) representing a generic Animal
class Animal
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{name} makes a sound"
  end

  def info
    "I am #{name}, a #{self.class.name.downcase}"
  end
end

# Subclass Cat inherits from Animal using < operator
class Cat < Animal
  # Inherited initialize is used - no need to redefine

  # Override the speak method (polymorphism)
  def speak
    "#{name} says Meow!"
  end
end

# Another subclass with its own initialize
class Bird < Animal
  attr_reader :wingspan

  # Call superclass initialize using super
  def initialize(name, wingspan)
    super(name) # Calls Animal's initialize
    @wingspan = wingspan
  end

  # Override speak method differently
  def speak
    "#{name} chirps!"
  end

  # Extend with additional method
  def fly
    "#{name} flies with a wingspan of #{wingspan}cm"
  end
end

puts "\n--- Inheritance Demo ---"
cat = Cat.new('Whiskers')
puts cat.speak  # Polymorphism: Cat's version
puts cat.info   # Inherited from Animal

bird = Bird.new('Tweety', 25)
puts bird.speak  # Polymorphism: Bird's version
puts bird.fly    # Bird-specific method
puts bird.info   # Inherited from Animal

# =============================================================================
# POLYMORPHISM EXAMPLE
# =============================================================================

# Polymorphism allows objects of different classes to be treated uniformly
# as long as they respond to the same messages (duck typing)

class Vehicle
  def move
    raise NotImplementedError, 'Subclasses must implement #move'
  end
end

class Car < Vehicle
  def move
    'Driving on the road'
  end
end

class Boat < Vehicle
  def move
    'Sailing on water'
  end
end

class Plane < Vehicle
  def move
    'Flying through the sky'
  end
end

# Polymorphic method - works with any object that implements #move
def transport(vehicles)
  vehicles.each_with_index do |vehicle, index|
    puts "Vehicle #{index + 1}: #{vehicle.move}"
  end
end

puts "\n--- Polymorphism Demo ---"
vehicles = [Car.new, Boat.new, Plane.new]
transport(vehicles)

# Duck typing example - doesn't need to inherit from Vehicle
class Runner
  def move
    'Running on foot'
  end
end

# Runner works with transport() even though it's not a Vehicle subtype
all_movers = [Car.new, Runner.new, Boat.new, Plane.new]
puts "\n--- Duck Typing Demo ---"
transport(all_movers)
