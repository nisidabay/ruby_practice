#!/usr/bin/env ruby
# frozen_string_literal: true

# instance_methods_cake.rb — defining instance methods

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

cake = Cake.new
puts cake.bake
puts cake.slice
puts cake.sell

