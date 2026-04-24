#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to track data that's shared across all instances of a class.
# Example: Counting how many customers have been created, regardless of which customer.
#
# Solution: Use class variables (@@variable) that are shared among all instances.
# Visibility: Class variables are accessible from instance methods and class methods.

class Customer
  @@total_customers = 0

  def initialize(id, name, addr)
    @@total_customers += 1
    @id = id
    @name = name
    @addr = addr
  end

  def display
    puts "Customer ##{@id}: #{@name}"
    puts "  Address: #{@addr}"
  end

  def self.total
    @@total_customers
  end
end

# Usage: Create instances, class variable tracks the count
cust1 = Customer.new(1, "Carlos", "Calle Hortensia, Granada")
cust1.display
puts "Total customers: #{Customer.total}"

cust2 = Customer.new(2, "Alicia", "Calle Topete, Madrid")
cust2.display
puts "Total customers: #{Customer.total}"

# This could also be done like this:
# For simpler cases, use a class instance variable instead of @@:
#
# class Customer
#   @total = 0
#
#   def self.total
#     @total
#   end
#
#   def initialize
#     self.class.instance_variable_set(:@total, @total.to_i + 1)
#   end
# end
