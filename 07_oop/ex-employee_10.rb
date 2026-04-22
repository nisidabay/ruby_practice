#!/usr/bin/env ruby
# frozen_string_literal: true

# The getters are set manually to validate data!

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

# Test the instances
amy = Employee.new('Amy Blake', 50_000)
amy.print_pay_stub
peter = Employee.new
peter.print_pay_stub
