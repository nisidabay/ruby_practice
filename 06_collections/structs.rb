#!/usr/bin/env ruby
# frozen_string_literal: true

# Structs
# This file contains Ruby code for structs.

# We define the Struct with three attributes
Person = Struct.new(:first_name, :last_name, :age) do
  # 1. A method to get the full name
  def full_name
    "#{first_name} #{last_name}"
  end

  # 2. A check (Predicate method) - Ruby convention uses '?'
  def adult?
    age >= 18
  end

  # 3. A method to modify the data "!" modifies the data, it's a convention
  def celebrate_birthday!
    self.age += 1
    puts "Happy Birthday, #{first_name}! You are now #{age}."
  end

  # 4. A method to get initials
  def initials
    "#{first_name[0]}#{last_name[0]}".upcase
  end
end

# --- Using the expanded Struct ---

user = Person.new('Jane', 'Doe', 17)

puts user.full_name # -> "Jane Doe"
puts user.adult?    # -> false (17 is less than 18)

# Time passes...
user.celebrate_birthday! # -> "Happy Birthday, Jane! You are now 18."

puts user.adult? # -> true (Now she is 18!)

puts user.initials # -> "JD"
