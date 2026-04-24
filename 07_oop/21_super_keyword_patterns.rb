#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You need to call a parent class method from a child class method.
# Example: Eagle.fly should call Bird.fly and add extra behavior.
#
# Solution: Use super to delegate to the parent implementation.
# Visibility: Depends on parent method visibility.

# Case 1: super with implicit arguments (passes all args automatically)
class Bird
  def fly(speed, altitude)
    "Flying at #{speed} mph and #{altitude} feet."
  end
end

class Eagle < Bird
  def fly(speed, altitude)
    super + " Also, I have keen eyesight."
  end
end

puts "=== Implicit Arguments ==="
puts Eagle.new.fly(30, 1000)

# Case 2: super with explicit arguments (change data before passing)
class Logger
  def log(message, level)
    "[#{level.upcase}] #{message}"
  end
end

class ErrorLogger < Logger
  def log(message)
    super(message, "error")
  end
end

puts "\n=== Explicit Arguments ==="
puts ErrorLogger.new.log("Database connection failed")

# Case 3: super() with no arguments (when parent takes different args)
class Parent
  def say_hello
    "Hello from the parent!"
  end
end

class Child < Parent
  def say_hello(name)
    super() + " Nice to meet you, #{name}."
  end
end

puts "\n=== No Arguments ==="
puts Child.new.say_hello("Alice")

# Case 4: super in initialize (share setup logic)
class User
  attr_reader :username

  def initialize(username)
    @username = username
  end
end

class Admin < User
  attr_reader :permissions

  def initialize(username, permissions)
    super(username)
    @permissions = permissions
  end
end

puts "\n=== Initialize Pattern ==="
admin = Admin.new("tech_guru", ["delete_user", "edit_post"])
puts "User: #{admin.username}, Perms: #{admin.permissions.join(', ')}"

# This could also be done like this:
# Pass blocks through super:
#
# class Calculator
#   def calculate(a, b)
#     result = a + b
#     yield(result) if block_given?
#   end
# end
#
# class Formatter < Calculator
#   def calculate(a, b)
#     super do |res|
#       puts "The formatted result is: #{res}"
#     end
#   end
# end
