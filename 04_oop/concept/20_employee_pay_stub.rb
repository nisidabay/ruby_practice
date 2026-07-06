#!/usr/bin/env ruby
# frozen_string_literal: true

# employee_pay_stub.rb — validated attributes + calculation method

class Employee
  attr_reader :name, :salary

  def initialize(name = 'Anonymous', salary = 0.0)
    self.name = name
    self.salary = salary
  end

  def name=(name)
    raise "Name can't be blank!" if name.empty?
    @name = name
  end

  def salary=(salary)
    raise "Invalid salary: #{salary}" if salary < 0
    @salary = salary
  end

  def print_pay_stub
    pay = ((@salary / 365.0) * 14).round(2)
    puts "Name: #{name}"
    puts "Pay This Period: $#{format('%.2f', pay)}"
  end
end

amy = Employee.new('Amy Blake', 50_000)
amy.print_pay_stub

peter = Employee.new
peter.print_pay_stub


# Thinking in Ruby
#
# Validated attributes (name= raises on empty, salary= raises on
# negative) combined with a calculation method (print_pay_stub) show the
# typical Ruby class pattern: enforce invariants on write, compute on
# read. The pay calculation with (salary / 365.0) * 14 demonstrates
# Ruby's division semantics — integer / float returns float.
