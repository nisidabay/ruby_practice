#!/usr/bin/env ruby
# frozen_string_literal: true

# times.rb — using Integer#times

def print_five_times
  5.times { print 'Hello' }
end

def money_printer(amount)
  amount.times { print 'Money' }
end

print_five_times  # => HelloHelloHelloHelloHello
puts
money_printer(3)  # => MoneyMoneyMoney
puts
