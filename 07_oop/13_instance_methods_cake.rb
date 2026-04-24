#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to create a class with multiple instance methods.
# Example: A Cake class with bake, slice, and sell methods.
#
# Solution: Define instance methods inside the class body.
# Visibility: Methods are PUBLIC by default.

class Cake
  def bake
    "Baking the cake"
  end

  def slice
    "Slicing the cake"
  end

  def sell
    "Sold the cake"
  end
end

# Usage: Create instance and call methods
cake = Cake.new
puts cake.bake
puts cake.slice
puts cake.sell

# This could also be done like this:
# Add state with initialize and instance variables:
#
# class Cake
#   def initialize(flavor)
#     @flavor = flavor
#   end
#
#   def bake
#     "Baking #{@flavor} cake"
#   end
# end
