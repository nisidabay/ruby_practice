#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to ensure employee data is valid and calculate pay stubs.
# Example: Name can't be blank, salary can't be negative, show bi-weekly pay.
#
# Solution: Use custom setters with validation and a helper method for calculations.
# Visibility: PUBLIC read access, validated write access, public helper methods.

class Employee
  attr_reader :name, :salary

  def initialize(name = 'Anonymous', salary = 0.0)
    self.name = name
    self.salary = salary
  end

  def name=(name)
    raise "Name can't be blank!" if name == ''

    @name = name
  end

  def salary=(salary)
    raise "A salary of #{salary} isn't valid" if salary < 0

    @salary = salary
  end

  def print_pay_stub
    puts "Name: #{name}"
    pay_for_period = (@salary / 365.0) * 14
    formatted_pay = format('%.2f', pay_for_period)
    puts "Pay This Period: $#{formatted_pay}"
  end
end

# Usage: Create employees and print pay stubs
amy = Employee.new('Amy Blake', 50_000)
amy.print_pay_stub

peter = Employee.new
peter.print_pay_stub

# Invalid data raises errors:
# Employee.new('', 0)  # Raises: Name can't be blank!
# Employee.new('Bob', -1000)  # Raises: A salary of -1000 isn't valid

# This could also be done like this:
# Use nil defaults and require explicit values:
#
# def initialize(name:, salary:)
#   self.name = name
#   self.salary = salary
# end
