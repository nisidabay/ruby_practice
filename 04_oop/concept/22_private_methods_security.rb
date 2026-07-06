#!/usr/bin/env ruby
# frozen_string_literal: true

require 'securerandom'

# private_methods_security.rb — hiding internals

class SmartPhone
  attr_reader :username

  def initialize(username, password)
    @username = username.capitalize
    @password = password
  end

  def upgrade_security!
    puts "Updating default password..."
    @password = generate_password
    @puk_number = generate_puk_number
  end

  def display_details
    puts "Username: #{@username}"
    puts "Password: #{@password}"
    puts "PUK: #{@puk_number || 'Not yet generated'}"
  end

  private

  def generate_password
    SecureRandom.alphanumeric(12)
  end

  def generate_puk_number
    SecureRandom.hex(6).upcase
  end
end

phone = SmartPhone.new("carlos", "12345")
phone.display_details
phone.upgrade_security!
phone.display_details

# phone.generate_password  # => private method error


# Thinking in Ruby
#
# private methods hide internal logic — generate_password and
# generate_puk_number are implementation details that callers shouldn't
# depend on. Ruby's private means "no explicit receiver" (not "hidden
# from subclasses"). Combined with the SecureRandom stdlib, Ruby makes
# encapsulation practical, not just theoretical.
