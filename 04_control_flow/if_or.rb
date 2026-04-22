#!/usr/bin/env ruby
# frozen_string_literal: true

# If or
# This file contains Ruby code for if or.

meal = 'Tuna'
price = 12.00

food_delicious = meal == 'Tuna'
affordable_price = price < 12.00

puts 'I eat today' if food_delicious || affordable_price
