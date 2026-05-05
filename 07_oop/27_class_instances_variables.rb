#!/usr/bin/env ruby
# frozen_string_literal: true

# class_instances_variables.rb — class instance vars vs class vars
# Problem: @@var is shared across entire hierarchy (rarely what you want)
# Solution: @var on class object — each class gets its own counter

class Person
  class << self
    attr_accessor :counter
  end
  @counter = 0                     # initialize counter on Person

  def initialize(name)
    @name = name
    self.class.counter += 1        # increments its OWN class's counter
  end

  attr_reader :name
end

class Student < Person
  @counter = 0                     # separate counter for Student
end

class Teacher < Person
  @counter = 0                     # separate counter for Teacher
end

Person.new('Alice')
Person.new('Bob')
Student.new('Carol')
Student.new('Dave')
Student.new('Eve')
Teacher.new('Prof. Smith')

puts "Person: #{Person.counter}"   # => 2
puts "Student: #{Student.counter}"  # => 3
puts "Teacher: #{Teacher.counter}"  # => 1

# If we used @@counter, ALL three would show 6.

