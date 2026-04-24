#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to hide internal implementation details from external access.
# Example: Password generation should be private, only upgrade_security! is public.
#
# Solution: Use the private keyword to mark methods as internal-only.
# Visibility: PUBLIC methods before private, PRIVATE methods after.

require 'securerandom'

class SmartPhone
  attr_reader :username

  def initialize(username, password)
    @username = username.capitalize
    @password = password
  end

  # Public method - updates security state
  def upgrade_security!
    puts "Updating default password to a stronger one..."
    @password = generate_password
    @puk_number = generate_puk_number
  end

  # Public method - displays current state
  def display_details
    puts "\nPhone Details"
    puts "-------------"
    puts "Username: #{@username}"
    puts "Password: #{@password}"
    puts "PUK Number: #{@puk_number || 'Not yet generated'}"
  end

  private

  # Private method - internal helper only
  def generate_password
    SecureRandom.alphanumeric(12)
  end

  # Private method - internal helper only
  def generate_puk_number
    SecureRandom.hex(6).upcase
  end
end

# Usage: Public methods work, private methods are protected
phone = SmartPhone.new("carlos", "12345")

phone.display_details
phone.upgrade_security!
phone.display_details

# Private methods cannot be called from outside:
# phone.generate_password  # Error: private method `generate_password'

# This could also be done like this:
# Use protected for methods accessible within the class hierarchy:
#
# class SmartPhone
#   protected
#
#   def compare_password(other)
#     @password == other.instance_variable_get(:@password)
#   end
# end
