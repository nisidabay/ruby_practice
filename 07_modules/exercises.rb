#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Module mixins practice

module Greeter
  def greet(name)
    puts "Hello, #{name}!"
  end
end

class User
  include Greeter
end

puts '=== Exercise 1: Include mixin ==='
user = User.new
user.greet('Carlos')
puts "

=== Exercise 2: Self method ==="
module MathHelper
  def self.square(n)
    n * n
  end
end
puts MathHelper.square(4)

puts "

=== Exercise 3: Module_function ==="
module Calculator
  def add(a, b)
    a + b
  end
  module_function :add # Make the function private. Only for the module
end
puts Calculator.add(3, 4)
