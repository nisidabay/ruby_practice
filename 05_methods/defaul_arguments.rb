#!/usr/bin/env ruby
# frozen_string_literal: true

# Defaul arguments
# This file contains Ruby code for defaul arguments.

def calculate_meal_cost(amount, tip = 0.20)
  amount + (amount * tip).to_i
end

def string_adder(_p1 = '', _p2 = '')
  "#{_p1} #{_p2}"
end

p calculate_meal_cost(20, 0.05)
p calculate_meal_cost(20)
p calculate_meal_cost(100, 0.12)
p calculate_meal_cost(100)

p string_adder('Hello', 'World')
p string_adder('Emilio', 'Estevez')
p string_adder
p string_adder('Tiger')
