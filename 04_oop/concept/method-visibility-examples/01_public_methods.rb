#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want methods that are callable from anywhere — the object's public API.
# Example: account.balance, account.deposit(50)
#
# Solution: Use public methods (the default in Ruby).
# Visibility: PUBLIC — callable by any object, anywhere.

class BankAccount
  attr_reader :balance

  def initialize(initial_balance)
    @balance = initial_balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end

# Usage: Public methods are callable from anywhere
account = BankAccount.new(100)
puts account.balance    # => 100
account.deposit(50)
puts account.balance    # => 150

# This could also be done like this:
# If you want to be explicit about visibility (useful when mixing visibility levels):
#
# class BankAccount
#   public  # Explicitly set default to public
#
#   def balance
#     @balance
#   end
# end

# Thinking in Ruby
#
# Public methods are Ruby's default — no access modifier needed. Every
# method is public unless explicitly declared otherwise. This "optimize
# for the common case" design means most methods start public and are
# made private only when a clear internal-API boundary is needed.
