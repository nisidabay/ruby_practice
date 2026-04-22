#!/usr/bin/env ruby
# Object-Oriented Programming Examples
# This file demonstrates Ruby OOP concepts including classes and modules.
# Shows inheritance, polymorphism, and encapsulation.

# frozen_string_literal: true

# !/usr/bin/ruby

require_relative 'lib_importing_classes/video'
require_relative 'lib_importing_classes/customer'

# Video with error handling
begin
  video = Video.new
  video.title = 'Classes en ruby'
  video.play
  video.pause
  video.stop
rescue ArgumentError => e
  puts "Video Error: #{e.message}"
rescue StandardError => e
  puts "Unexpected Error: #{e.message}"
ensure
  puts 'Video operations completed'
end

# Customer with error handling
begin
  cust1 = Customer.new(1, 'Carlos', 'Calle Hortensia, Granada')
  cust1.display_details
  Customer.total_no_of_customers

  cust2 = Customer.new(2, 'Alicia', 'Calle Topete, Madrid')
  cust2.display_details
  Customer.total_no_of_customers

  puts "\n--- Testing Error Handling ---"
  # This will trigger the rescue block
  Customer.new(nil, 'Test', 'Test Address')
rescue ArgumentError => e
  puts "Validation Error: #{e.message}"
rescue StandardError => e
  puts "Unexpected Error: #{e.message}"
ensure
  puts "\nFinal customer count:"
  Customer.total_no_of_customers
end
