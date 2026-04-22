#!/usr/bin/env ruby
# frozen_string_literal: true

# Object-Oriented Programming Examples
# This file demonstrates Ruby OOP concepts including:
# - Class definition and structure
# - Attribute accessors (attr_accessor for getters/setters)
# - Instance variables (@variable) - unique to each object
# - Class variables (@@variable) - shared across all instances
# - Initialize method (constructor)

class Video
  # attr_accessor is a getter/setter method
  attr_accessor :time, :title

  def play
    puts "video playing #{title}"
  end

  def pause
    puts "video paused #{title}"
  end

  def stop
    puts "video stopped #{title}"
  end
end

video = Video.new
puts video.class
video.title = 'Classes en ruby'
video.play
video.pause

class Customer
  # class variable. Shared among all objects of the class
  @@no_of_customers = 0
  def initialize(id, name, addr)
    @@no_of_customers += 1

    # instance variables
    @cust_id = id
    @cust_name = name
    @cust_addr = addr
  end

  def display_details
    puts "Customer id #{@cust_id}"
    puts "Customer name #{@cust_name}"
    puts "Customer address #{@cust_addr}"
  end

  def total_no_of_customers
    puts "Total number of customers: #{@@no_of_customers}"
  end
end

cust1 = Customer.new(1, 'Carlos', 'Calle Hortensia, Granada')
cust1.display_details
cust1.total_no_of_customers

cust2 = Customer.new(2, 'Alicia', 'Calle Topete, Madrid')
cust2.display_details

cust2.total_no_of_customers
