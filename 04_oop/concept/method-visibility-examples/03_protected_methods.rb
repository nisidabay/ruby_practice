#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You need to compare two objects by their internal state.
# Example: account1 == account2 (do they have the same balance?)
#
# Solution: Use protected methods so same-class instances can access each other's state.
# Visibility: PROTECTED — callable by any instance of the same class.

class BankAccount
  attr_reader :id

  def initialize(id, balance)
    @id = id
    @balance = balance
  end

  # Compare if two accounts have the same balance
  def ==(other)
    # Can't do this - balance is not public:
    # return false unless other.is_a?(BankAccount)
    # @balance == other.balance  # NoMethodError!
    
    # Need protected to access other.balance
    return false unless other.is_a?(BankAccount)
    balance == other.balance  # ✓ Works!
  end

  # Check if this account has more money than another
  def >(other)
    balance > other.balance  # ✓ Can access other's protected method
  end

  protected

  attr_reader :balance
end

# Usage: Protected enables cross-instance comparison
account1 = BankAccount.new(1, 100)
account2 = BankAccount.new(2, 100)
account3 = BankAccount.new(3, 50)

puts account1 == account2   # => true (same balance)
puts account1 == account3   # => false (different balance)
puts account1 > account3    # => true (100 > 50)

# But external code can't access balance directly
# puts account1.balance     # => NoMethodError: protected method

# This could also be done like this:
# If balance should be public for reading but you still want to compare:
#
# class BankAccount
#   public attr_reader :balance  # Make it public
#   
#   def ==(other)
#     @balance == other.balance  # Still works, but now anyone can read balance
#   end
# end
#
# Use protected when the attribute is internal but needed for same-class operations.
