#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want class methods to have different visibility levels.
# Example: A public factory method that calls a private builder method.
#
# Solution: Use private_class_method and public_class_method.
# Visibility: PRIVATE/PUBLIC on class-level methods.

class BankAccount
  attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  # Public class method (factory pattern)
  def self.create_with_bonus(bonus)
    base = 100
    new(base + bonus)
  end

  # Private class method (internal builder)
  private_class_method def self.create_internal(initial)
    new(initial)
  end

  public_class_method def self.create_standard
    create_internal(100)
  end
end

# Usage: Class method visibility
account1 = BankAccount.create_with_bonus(50)
puts account1.balance     # => 150

account2 = BankAccount.create_standard
puts account2.balance     # => 100

# BankAccount.create_internal(200)  # => NoMethodError: private class method

# This could also be done like this:
# Set visibility after definition using symbols:
#
# class Example
#   def self.public_method; end
#   def self.private_method; end
#
#   private_class_method :private_method
#   public_class_method :public_method
# end
