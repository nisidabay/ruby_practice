#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Method arguments: positional, keyword, splat, double-splat

# --- Positional arguments ---
def full_name(first, last)
  "#{first} #{last}"
end
puts full_name("Carlos", "Nisida")  # => Carlos Nisida

# --- Keyword arguments with defaults ---
def order(item:, size: "medium", extras: [])
  base = "#{size} #{item}"
  extras.any? ? "#{base} with #{extras.join(', ')}" : base
end
puts order(item: "latte")                    # => medium latte
puts order(item: "latte", size: "large")     # => large latte
puts order(item: "latte", extras: ["syrup"]) # => medium latte with syrup

# --- Splat (*): variable number of arguments ---
def shopping_list(*items)
  items.map.with_index { |item, i| "#{i + 1}. #{item}" }.join("\n")
end
puts shopping_list("bread", "milk", "eggs")

# --- Double-splat (**): catch extra keyword args ---
def configure(required:, **optional)
  { required: required }.merge(optional)
end
puts configure(required: "host", port: 5432, debug: true).inspect
# => {:required=>"host", :port=>5432, :debug=>true}

# --- BONUS: Write a method that takes *args and finds the median ---
