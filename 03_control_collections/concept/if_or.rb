#!/usr/bin/env ruby
# frozen_string_literal: true

# if_or.rb — inline if with ||

meal = 'Tuna'
price = 12.00

delicious = meal == 'Tuna'
affordable = price < 12.00

puts 'I eat today' if delicious || affordable

# Thinking in Ruby
#
# Ruby's trailing-if modifier (action if condition) reads like natural
# English and works with any expression, including compound conditions
# with || and &&. This postfix syntax is unique to Ruby — it turns guard
# clauses into inline assertions that don't break the flow of a thought.
