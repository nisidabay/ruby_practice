#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to restrict write access to an attribute and validate changes.
# Example: A dog's name can't be blank, age must be a positive integer.
#
# Solution: Use attr_reader and define custom setter methods with validation.
# Visibility: PUBLIC read access, validated write access.

class Dog
  attr_reader :name, :age

  def name=(value)
    raise "Name can't be blank!" if value.empty?

    @name = value
  end

  def age=(value)
    raise "An age of #{value} isn't valid" unless value.is_a?(Integer) && value.positive?

    @age = value
  end

  def report
    puts "#{name} is #{age} years old"
  end
end

# Usage: Create instance and use validated setters
dog = Dog.new
dog.name = 'Pepe'
dog.age = 2
dog.report

# These will raise errors:
# dog.name = ''     # Raises: Name can't be blank!
# dog.age = -1      # Raises: An age of -1 isn't valid

# This could also be done like this:
# If you want to allow nil values or have different validation rules,
# use attr_accessor and override both getter and setter:
#
# class Dog
#   attr_accessor :name
#
#   def age
#     @age
#   end
#
#   def age=(value)
#     @age = value if value && value > 0
#   end
# end
