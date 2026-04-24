#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want one class to contain another, but the contained object can exist independently.
# Example: A Department has Professors - if the department closes, professors still exist.
#
# Solution: Use aggregation - pass the dependent object from outside, don't create it internally.
# Visibility: The contained object is created externally and passed in.

class Professor
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Department
  attr_reader :name, :professors

  def initialize(name)
    @name = name
    @professors = []
  end

  def add_professor(professor)
    @professors << professor
  end
end

# Usage: Create objects independently, then associate them
dr_smith = Professor.new("Dr. Smith")
dr_jones = Professor.new("Dr. Jones")

history_dept = Department.new("History")
history_dept.add_professor(dr_smith)
history_dept.add_professor(dr_jones)

puts "#{dr_smith.name} belongs to the #{history_dept.name} department."
puts "The department has #{history_dept.professors.length} professors."

# If the department is destroyed, professors still exist:
history_dept = nil
puts "\nAfter department closes:"
puts "#{dr_smith.name} still exists and can join another department."

# This could also be done like this:
# If you want to access professors directly, add a helper method:
#
# class Department
#   def professor_names
#     @professors.map(&:name)
#   end
# end
#
# puts history_dept.professor_names.join(", ")
