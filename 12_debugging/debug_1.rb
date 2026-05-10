#!/usr/bin/env ruby
# frozen_string_literal: true

# debug_1.rb — binding.break suspends execution in-place

# WITHOUT debugger — puts-everywhere archaeology:
#
#   amount = 149.99
#   puts "amount=#{amount}"  # guesswork
#   tax = amount * 0.08
#   puts "tax=#{tax}"        # more guesswork
#   total = amount + tax
#   puts "total=#{total}"    # this doesn't scale
#
# WITH debugger — inspect live:

require 'debug'

order = {item: "latte", price: 4.50, quantity: 3}
binding.break  # type 'order' here to see the hash — live inspection
total = order[:price] * order[:quantity]
puts "$#{total}"
