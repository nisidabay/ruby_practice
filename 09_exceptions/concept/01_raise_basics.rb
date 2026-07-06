#!/usr/bin/env ruby
# frozen_string_literal: true

# 01_raise_basics.rb — raise stops execution and sends a message up the stack
#
# WITHOUT raise — you handle problems silently and the caller never knows:
#
#   def transfer(amount)
#     if amount > balance
#       puts "Insufficient funds"     # caller keeps running, no idea it failed
#       return
#     end
#     # ...
#   end
#
# WITH raise — the caller MUST deal with it or the program stops:

class Account
  def initialize(balance)
    @balance = balance
  end

  def withdraw(amount)
    raise ArgumentError, "Amount must be positive" if amount <= 0

    if amount > @balance
      raise "Insufficient funds: tried to withdraw #{amount}, balance is #{@balance}"
    end

    @balance -= amount
    puts "Withdrew #{amount}, new balance: #{@balance}"
  end
end

acc = Account.new(100)
acc.withdraw(30)   # works

begin
  acc.withdraw(200)  # blows up
rescue => e
  puts "Transfer failed: #{e.message}"  # => "Insufficient funds: tried to withdraw 200..."
end

# raise with a string creates a RuntimeError.
# raise with a class + message is precise:
#   raise ArgumentError, "bad input"
#   raise Errno::ENOENT, "file missing"  # you can raise system errors too

# Thinking in Ruby
#
# raise in Ruby is both statement and expression — it stops execution and
# sends a message up the call stack. Unlike many languages where you can
# only throw predefined exception types, Ruby lets you raise any class
# inheriting from StandardError, including system errors like Errno::ENOENT.
# The two-argument form (raise Class, message) is precise: the class
# identifies the error type, the message carries the context. No separate
# throw/catch distinction — just raise and rescue.
