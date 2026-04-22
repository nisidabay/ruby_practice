#!/usr/bin/env ruby
# frozen_string_literal: true

# This Ruby script demonstrates a simple **modular logging system**
#
# Modules
# This file contains Ruby code for modules.
# An **object-oriented design** with inheritance-like behavior (via
# `include`). Here's what it does:

### Purpose:
# - **Demonstrates Mixins**: Shows how to share behavior (logging)
# across unrelated classes using `include`.
# - **Encapsulation**: Logs are centralized in the module, avoiding
# code duplication.
# - **Extensibility**: New classes (e.g., `Payment`, `Report`) can
# easily add logging by including `Loggable`.

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

new_user = User.new
new_user.name = 'Carlos'
new_user.login
Order.new.confirm
