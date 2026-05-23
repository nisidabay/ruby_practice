#!/usr/bin/env ruby
# frozen_string_literal: true

# aggregation_department_professor.rb — objects pass in from outside

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

dr_smith = Professor.new("Dr. Smith")
dr_jones = Professor.new("Dr. Jones")

history = Department.new("History")
history.add_professor(dr_smith)
history.add_professor(dr_jones)

puts "#{dr_smith.name} belongs to #{history.name} department."
puts "Department has #{history.professors.length} professors."

# Department destroyed, professors still exist independently
history = nil
puts "#{dr_smith.name} still exists and can join another department."

