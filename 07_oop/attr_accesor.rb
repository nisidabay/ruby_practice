#!/usr/bin/env ruby
# frozen_string_literal: true

# This script demonstrates Ruby's attr_accessor, which automatically creates
# getter and setter methods for instance variables. 

# This way of creating automatic setters/getters HAS NO VALIDATION!

class Dog
  attr_accessor :name, :age

  def report_age
    puts "#{@name} is #{@age} years old"
  end
end

#--- Objects creation
fido = Dog.new
fido.name = 'Fido'
fido.age = 2
fido.report_age
fido.age = -1 # THIS WILL RUN NORMALLY WITHOUT VALIDATION.
