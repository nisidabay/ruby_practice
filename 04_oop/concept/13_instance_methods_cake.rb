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


# Thinking in Ruby
#
# Instance methods (defined with def inside the class body without self.)
# belong to instances, not the class itself. Each Cake instance responds
# to bake, slice, and sell. The return value of each method is the last
# expression evaluated — implicit returns keep the code clean.
