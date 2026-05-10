#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Define and call methods with parameters

def greet(name, time_of_day)
  "Good #{time_of_day}, #{name}!"
end

puts greet("Carlos", "morning")  # => Good morning, Carlos!

# --- Write a method `add` that takes two numbers and returns their sum ---

# --- Write a method `shout` that takes a string and returns it UPCASED ---

# --- Write a method with a default argument ---
# def order(item, size = "medium")

# --- BONUS: Write a method that takes a block and calls it twice ---
# Hint: def twice; yield; yield; end
