#!/usr/bin/env ruby
# frozen_string_literal: true
# Method Examples
# This file demonstrates Ruby method definitions and usage.
# Shows parameter handling, blocks, and method chaining.


# Creates a hash, a dict in Python
contacts = { carlos: 1, alicia: 2, sergio: 3, clara: 4, daniele: 5 }

# Display the hash
puts "Contacts: #{contacts}"

# Fetch specific values
puts "Fetch value for :alicia: #{contacts.fetch(:alicia)}"

# Display all values
puts "Values: #{contacts.values}"

# Display all keys
puts "Keys: #{contacts.keys}"

# Check if a key exists
puts "Has key :carlos? #{contacts.key?(:carlos)}"

# Check if a value exists
puts "Has value 3? #{contacts.value?(3)}"

# Invert keys and values
puts "Inverted: #{contacts.invert}"

# Merge with another hash
additional_contacts = { juan: 6, maria: 7 }
puts "Merged: #{contacts.merge(additional_contacts)}"

# Delete a key-value pair
contacts.delete(:sergio)
puts "After deleting :sergio: #{contacts}"

# Iterate over each key-value pair
puts 'Iterating over contacts:'
contacts.each do |key, value|
  puts "#{key}: #{value}"
end

# Clear the hash
contacts.clear
puts "After clearing: #{contacts}"

# Recreate hash for additional methods
contacts = { carlos: 1, alicia: 2, sergio: 3, clara: 4, daniele: 5 }

# Iterate over keys only
puts 'All keys:'
contacts.each_key { |key| puts key }

# Iterate over values only
puts 'All values:'
contacts.each_value { |value| puts value }

# Select/filters pairs based on condition
puts "Selected (value > 2): #{contacts.select { |_key, value| value > 2 }}"
puts "Rejected (value > 2): #{contacts.reject { |_key, value| value > 2 }}"
