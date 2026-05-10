#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Hash operations: create, access, iterate, transform

# --- Create a hash mapping country -> capital ---
capitals = {
  "Spain" => "Madrid",
  "Japan" => "Tokyo",
  "Brazil" => "Brasilia",
  "Canada" => "Ottawa",
}

# --- Look up and handle missing keys ---
puts capitals["Spain"]       # => Madrid
puts capitals["Germany"]     # => nil — make this print "Not found" instead
# Hint: capitals.fetch("Germany", "Not found")

# --- Add a new country ---
capitals["France"] = "Paris"

# --- Iterate: print all key-value pairs ---
capitals.each do |country, capital|
  puts "#{capital} is the capital of #{country}"
end

# --- Transform: create a hash of country -> capital length ---
# lengths = capitals.transform_values { |v| v.length }
# puts lengths  # => {"Spain"=>6, "Japan"=>5, ...}

# --- BONUS: count word frequency in a sentence ---
# sentence = "the cat in the hat sat on the mat"
# freq = Hash.new(0)
# sentence.split.each { |w| freq[w] += 1 }
# puts freq  # => {"the"=>3, "cat"=>1, ...}
