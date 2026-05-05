#!/usr/bin/env ruby
# frozen_string_literal: true

# modules_loggable_mixin.rb — sharing behavior via module include

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

user = User.new
user.name = 'Carlos'
user.login

Order.new.confirm

