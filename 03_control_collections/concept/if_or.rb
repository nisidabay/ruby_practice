#!/usr/bin/env ruby
# frozen_string_literal: true

# if_or.rb — inline if with ||

meal = 'Tuna'
price = 12.00

delicious = meal == 'Tuna'
affordable = price < 12.00

puts 'I eat today' if delicious || affordable
