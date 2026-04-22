#!/usr/bin/env ruby
# frozen_string_literal: true

# Times
# This file contains Ruby code for times.

def print_five_times
  5.times { print 'Hello' }
end

def money_printer(value)
  value.times { print 'Money' }
end

print_five_times
money_printer(3)
money_printer(5)
money_printer(0)
