#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want helper methods that are only callable within the class itself.
# Example: validate_balance should run during withdraw, but not be callable externally.
#
# Solution: Use private methods.
# Visibility: PRIVATE — callable only without an explicit receiver (no `self.` or `obj.`).

class BankAccount
  attr_reader :balance

  def initialize(initial_balance)
    @balance = initial_balance
    validate_balance  # ✓ Works: implicit receiver
  end

  def deposit(amount)
    @balance += amount
    log_transaction(:deposit, amount)  # ✓ Works: implicit receiver
  end

  def withdraw(amount)
    return false unless sufficient_funds?(amount)
    @balance -= amount
    log_transaction(:withdraw, amount)
    true
  end

  private

  def validate_balance
    raise "Balance cannot be negative" if @balance.negative?
  end

  def sufficient_funds?(amount)
    amount <= @balance
  end

  def log_transaction(type, amount)
    puts "[LOG] #{type}: #{amount} | New balance: #{@balance}"
  end
end

# Usage: Public methods work, private methods don't
account = BankAccount.new(100)
account.deposit(50)         # => [LOG] deposit: 50 | New balance: 150
account.withdraw(30)        # => [LOG] withdraw: 30 | New balance: 120

# account.validate_balance    # => NoMethodError: private method
# account.sufficient_funds?(10)  # => NoMethodError: private method

# This could also be done like this:
# If you need to test private methods, use `send` (use sparingly):
#
# account.send(:validate_balance)  # Bypasses visibility (testing only)
#
# Or in Ruby 2.7+, private setters work with explicit `self.`:
#
# class Example
#   private
#   attr_writer :counter
#
#   def increment
#     self.counter = counter + 1  # ✓ Works for setters only
#   end
# end

# Thinking in Ruby
#
# Private methods in Ruby have a specific rule: no explicit receiver
# (no self., no obj.). This differs from Java/C++ where private means
# "not inherited." Ruby's private means "functional helper of self" —
# called from within the class but not on another instance, even of
# the same class.
