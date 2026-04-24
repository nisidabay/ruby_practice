#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want a mix of read-only and read-write attributes.
# Example: @to, @from, @amount are read-only, but @completed can be changed.
#
# Solution: Use attr_reader for read-only, attr_accessor for read-write.
# Visibility: PUBLIC - readers for all, writer only for completed.

class FinancialTransaction
  attr_reader :to, :from, :amount
  attr_accessor :completed

  def initialize(to, from, amount, completed)
    @to = to
    @from = from
    @amount = amount
    @completed = completed
  end
end

# Usage: Read all attributes, modify only completed
my_rent = FinancialTransaction.new("Landlord", "Boris", 1000, false)
puts my_rent.to
puts my_rent.from
puts my_rent.amount
puts my_rent.completed

my_rent.completed = true
puts my_rent.completed

# This will fail (no setter for to, from, amount):
# my_rent.to = "Someone"  # Error: undefined method `to='

# This could also be done like this:
# If you want validation on completed:
#
# class FinancialTransaction
#   attr_reader :to, :from, :amount, :completed
#
#   def completed=(value)
#     @completed = value if [true, false].include?(value)
#   end
# end
