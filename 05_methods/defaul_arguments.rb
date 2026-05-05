#!/usr/bin/env ruby
# frozen_string_literal: true

# default_arguments.rb — defaults and unused params

def calculate_meal_cost(amount, tip = 0.20)
  amount + (amount * tip).to_i
end

p calculate_meal_cost(20, 0.05)  # => 21
p calculate_meal_cost(20)        # => 24 (uses default 0.20)

def string_adder(a = '', b = '')
  "#{a} #{b}".strip
end

p string_adder('Hello', 'World')  # => "Hello World"
p string_adder                    # => ""
p string_adder('Tiger')           # => "Tiger"
