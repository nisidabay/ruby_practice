#!/usr/bin/env ruby
# frozen_string_literal: true

# super_keyword_patterns.rb — four super patterns

# 1. Implicit: passes all args automatically
class Bird
  def fly(speed, altitude)
    "Flying at #{speed}mph, #{altitude}ft."
  end
end

class Eagle < Bird
  def fly(speed, altitude)
    super + " Also, I have keen eyesight."
  end
end

puts Eagle.new.fly(30, 1000)

# 2. Explicit: change args before passing
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

puts ErrorLogger.new.log("DB connection failed")

# 3. super() with no args (parent uses different signature)
class Parent
  def say_hello
    "Hello from parent!"
  end
end

class Child < Parent
  def say_hello(name)
    super() + " Nice to meet you, #{name}."
  end
end

puts Child.new.say_hello("Alice")

# 4. super in initialize
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

admin = Admin.new("tech_guru", %w[delete_user edit_post])
puts "User: #{admin.username}, Perms: #{admin.permissions.join(', ')}"


# Thinking in Ruby
#
# super has four distinct patterns: implicit (passes all args), explicit
# (passes different args), super() (no args), and super in initialize.
# Unlike C++ or Java where parent calls are virtual by default, Ruby's
# super is explicit — you choose which parent behavior to reuse and how.
