#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want one class to fully manage the lifecycle of another object it contains.
# Example: A Spaceship has an Engine - the engine is created inside the ship and dies with it.
#
# Solution: Use composition - create the dependent object inside the parent's constructor.
# Visibility: The contained object is private, created and managed internally.

class Engine
  def start
    "Vroom!"
  end
end

class Spaceship
  def initialize(name)
    @name = name
    # Engine is created INSIDE the spaceship
    # It doesn't exist before the ship, and dies with the ship
    @engine = Engine.new
  end

  def launch
    puts "Launching #{@name}: #{@engine.start}"
  end
end

# Usage: Create the parent, child is created automatically
discovery = Spaceship.new("Discovery One")
discovery.launch

# We never created the Engine manually - the Spaceship handled it
# If the spaceship is destroyed, the engine is too:
discovery = nil
puts "\nAfter spaceship is destroyed, the engine no longer exists."

# This could also be done like this:
# If you need to customize the engine, pass it as a parameter:
#
# class Spaceship
#   def initialize(name, engine = Engine.new)
#     @name = name
#     @engine = engine
#   end
# end
#
# turbo_engine = Engine.new
# ship = Spaceship.new("Enterprise", turbo_engine)
