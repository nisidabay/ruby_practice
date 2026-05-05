#!/usr/bin/env ruby
# frozen_string_literal: true

# composition_spaceship_engine.rb — child created inside parent, dies with it

class Engine
  def start
    "Vroom!"
  end
end

class Spaceship
  def initialize(name)
    @name = name
    @engine = Engine.new    # engine is created here, owned by this ship
  end

  def launch
    puts "Launching #{@name}: #{@engine.start}"
  end
end

discovery = Spaceship.new("Discovery One")
discovery.launch

discovery = nil  # spaceship gone → engine gone too
puts "After spaceship destroyed, the engine no longer exists."

