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

puts "=== Exercise 1: Include mixin ==="
user = User.new
# HINT: user.greet("Carlos")

puts "
=== Exercise 2: Self method ==="
module MathHelper
  def self.square(n)
    # --- your code here ---
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
  # --- your code here ---
  # HINT: module_function :add
end
puts Calculator.add(3, 4)
