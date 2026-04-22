#!/usr/bin/env ruby
require 'securerandom'

class SmartPhone
  # Use attr_reader for username, but avoid a reader for password for security
  attr_reader :username

  def initialize(username, password)
    @username = username.capitalize
    @password = password
  end

  # Separated logic: This method actually updates the state
  def upgrade_security!
    puts "Updating default password to a stronger one..."
    @password = generate_password
    @puk_number = generate_puk_number
  end

  # Separated presentation: This method only displays current state
  def display_details
    puts "\nPhone Details"
    puts "-------------"
    puts "Username: #{@username}"
    puts "Password: #{@password}"
    puts "PUK Number: #{@puk_number || 'Not yet generated'}"
  end

  private

  def generate_password
    SecureRandom.alphanumeric(12)
  end

  def generate_puk_number
    SecureRandom.hex(6).upcase
  end
end

# --- Execution ---
phone = SmartPhone.new("carlos", "12345")

# 1. Show initial state
phone.display_details

# 2. Update the security state
phone.upgrade_security!

# 3. Show updated state
phone.display_details
