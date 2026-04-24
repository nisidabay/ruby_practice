#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to read instance variables but don't want to use attr_reader.
# Example: Manually defining getter methods for @maker, @model, @seats.
#
# Solution: Define methods that return the instance variable values.
# Visibility: PUBLIC getter methods.

class Airplane
  def initialize
    @maker = "Boeing"
    @model = 757
    @seats = 60
  end

  def maker
    @maker
  end

  def model
    @model
  end

  def seats
    @seats
  end
end

# Usage: Call getter methods to read values
airplane = Airplane.new
puts airplane.maker
puts airplane.model
puts airplane.seats

# This could also be done like this:
# Use attr_reader to auto-generate these methods:
#
# class Airplane
#   attr_reader :maker, :model, :seats
#
#   def initialize
#     @maker = "Boeing"
#     @model = 757
#     @seats = 60
#   end
# end
