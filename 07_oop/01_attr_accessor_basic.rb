#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to quickly create getter and setter methods for instance variables.
# Example: dog.name = "Fido" and dog.name to read it back.
#
# Solution: Use attr_accessor to auto-generate both methods.
# Visibility: PUBLIC read and write access.
# Warning: NO validation - any value can be assigned!

class Dog
  attr_accessor :name, :age

  def report_age
    puts "#{@name} is #{@age} years old"
  end
end

# Usage: Create instance and set attributes directly
dog = Dog.new
dog.name = 'Fido'
dog.age = 2
dog.report_age

# Invalid values are accepted without error:
dog.age = -1 # This runs without complaint (bad!)
dog.report_age
