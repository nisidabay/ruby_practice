#!/usr/bin/env ruby
# frozen_string_literal: true

# Customer
# This file contains Ruby code for customer.

class Customer
  @@no_of_customers = 0

  def initialize(id, name, addr)
    validate_input!(id, name, addr)

    @@no_of_customers += 1
    @cust_id = id
    @cust_name = name
    @cust_addr = addr
  end

  def display_details
    puts "Customer id #{@cust_id}"
    puts "Customer name #{@cust_name}"
    puts "Customer address #{@cust_addr}"
  end

  def self.total_no_of_customers
    puts "Total number of customers: #{@@no_of_customers}"
  end

  private # Moved validation to private for better encapsulation

  def validate_input!(id, name, addr)
    raise ArgumentError, 'ID cannot be nil' if id.nil?
    raise ArgumentError, 'Name cannot be nil or empty' if name.to_s.strip.empty?
    raise ArgumentError, 'Address cannot be nil or empty' if addr.to_s.strip.empty?
    raise ArgumentError, 'ID must be a number' unless id.is_a?(Numeric)
  end
end
