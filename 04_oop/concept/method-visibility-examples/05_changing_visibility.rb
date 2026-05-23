#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to change a method's visibility after defining it.
# Example: Define all methods first, then set visibility with symbols.
#
# Solution: Use private :method_name, protected :method_name, public :method_name.
# Visibility: Explicitly set visibility using method names as symbols.

class BankAccount
  attr_reader :balance

  def initialize(initial_balance)
    @balance = initial_balance
  end

  def deposit(amount)
    @balance += amount
    log_transaction(:deposit, amount)
  end

  def withdraw(amount)
    @balance -= amount if sufficient_funds?(amount)
    log_transaction(:withdraw, amount)
  end

  def balance
    @balance
  end

  def log_transaction(type, amount)
    puts "[LOG] #{type}: #{amount}"
  end

  def sufficient_funds?(amount)
    amount <= @balance
  end

  # Change visibility after definition (explicit with symbols)
  private :log_transaction, :sufficient_funds?
  public :balance, :deposit, :withdraw
end

# Usage: Methods have the visibility we set
account = BankAccount.new(100)
account.deposit(50)         # => [LOG] deposit: 50
account.withdraw(30)        # => [LOG] withdraw: 30
puts account.balance        # => 120

# account.log_transaction(:test, 10)    # => NoMethodError: private
# account.sufficient_funds?(50)         # => NoMethodError: private

# This could also be done like this:
# Mix both styles (subsequent methods + symbols):
#
# class Example
#   def public_method; end
#
#   private  # Affects subsequent methods
#   def private1; end
#   def private2; end
#
#   public :private1  # Make private1 public again (yes, you can do this!)
# end
