#!/usr/bin/env ruby
# frozen_string_literal: true

# =============================================================================
# 1. INHERITANCE ("is-a" relationship)
# One class derives its behavior and properties from another.
# Use this when a child class is a specialized version of the parent.
# =============================================================================

class Vehicle
  attr_reader :brand

  def initialize(brand)
    @brand = brand
  end

  def move
    "The #{@brand} is moving."
  end
end

# A Car "is-a" Vehicle
class Car < Vehicle
  def move
    "#{super} It rolls on four wheels."
  end
end

# =============================================================================
# 2. AGGREGATION ("has-a" relationship - weak coupling)
# One class contains another, but the contained object can exist independently.
# If the "parent" is destroyed, the "child" lives on.
# =============================================================================

class Professor
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Department
  attr_reader :name, :professors

  def initialize(name)
    @name = name
    @professors = []
  end

  def add_professor(professor)
    @professors << professor
  end
end

# Example usage:
# If the Department closes, the Professor still exists in the system.
dr_smith = Professor.new("Dr. Smith")
history_dept = Department.new("History")
history_dept.add_professor(dr_smith)

# =============================================================================
# 3. COMPOSITION ("has-a" relationship - strong coupling)
# One class is composed of others. The contained objects are managed by the 
# parent and usually cannot exist (or have no meaning) without it.
# If the parent is destroyed, the children are destroyed too.
# =============================================================================

class Engine
  def start
    "Vroom!"
  end
end

class Spaceship
  def initialize(name)
    @name = name
    # The Engine is created INSIDE the Spaceship.
    # It doesn't exist before the ship, and dies with the ship.
    @engine = Engine.new 
  end

  def launch
    puts "Launching #{@name}: #{@engine.start}"
  end
end

# =============================================================================
# EXECUTION & DEMONSTRATION
# =============================================================================

puts "--- Inheritance ---"
my_car = Car.new("Toyota")
puts my_car.move # Output: The Toyota is moving. It rolls on four wheels.

puts "\n--- Aggregation ---"
puts "#{dr_smith.name} belongs to the #{history_dept.name} department."
# Note: dr_smith was created outside and passed in.

puts "\n--- Composition ---"
discovery = Spaceship.new("Discovery One")
discovery.launch
# Note: We never created the Engine manually; the Spaceship handled it.
