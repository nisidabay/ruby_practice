#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to share behavior (like logging) across unrelated classes.
# Example: Both User and Order classes need to log events, but they're not related.
#
# Solution: Create a module with the shared behavior and include it in each class.
# Visibility: Module methods become instance methods in the including class.

module Loggable
  def log(msg)
    puts "[#{Time.now}] LOG: #{msg}"
  end
end

class User
  include Loggable

  attr_accessor :name

  def login
    raise "Name can't be blank!" if @name.empty?

    log("User #{name} logged in!")
  end
end

class Order
  include Loggable

  def confirm
    log('Order processed')
  end
end

# Usage: Include the module to get logging behavior
new_user = User.new
new_user.name = 'Carlos'
new_user.login

Order.new.confirm

# This could also be done like this:
# If you want module methods available on the module itself too:
#
# module Loggable
#   def log(msg)
#     puts "[#{Time.now}] LOG: #{msg}"
#   end
#   module_function :log
# end
#
# Loggable.log("Direct module call")  # Works
# class User
#   include Loggable
# end
