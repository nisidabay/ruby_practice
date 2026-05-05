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
