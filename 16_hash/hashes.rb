#!/usr/bin/env ruby
# frozen_string_literal: true

#
# Hashes
# This file contains Ruby code for hashes.

# Hashes in Ruby

# Creating hashes
puts '=== Creating Hashes ==='

# Method 1: Using hash literal
empty_hash = {}
puts "Empty hash: #{empty_hash}"

# Method 2: Using Hash.new
another_empty = {}
puts "Hash.new: #{another_empty}"

# Method 3: With default value
hash_with_default = Hash.new(0)
puts "Accessing missing key returns default: #{hash_with_default[:missing]}"
puts "Hash is still empty: #{hash_with_default}"

# Method 4: With default value block
hash_with_block = Hash.new { |hash, key| hash[key] = [] }
hash_with_block[:items] << 'something'
puts "Block default: #{hash_with_block}"

# Method 5: Symbol keys (most common)
person = { name: 'Alice', age: 30, city: 'NYC' }
puts "Symbol keys: #{person}"

# Method 6: String keys
string_keys = { 'name' => 'Bob', 'age' => 25 }
puts "String keys: #{string_keys}"

# Method 7: Mixed keys (not recommended)
mixed = { 'name' => 'Charlie', age: 35, '2' => '4', 3 => 9, :five => 'twenty-five',
          ten: 10 }
puts "Mixed keys: #{mixed}"

puts "\n=== Accessing Values ==="

person = { name: 'Alice', age: 30, city: 'NYC' }

# Using square brackets
puts "Name: #{person[:name]}"

# Fetch with default
puts "Missing key with default: #{person.fetch(:country, 'USA')}"

# Fetch with block
puts "Fetch with block: #{person.fetch(:country) { |k| "Unknown: #{k}" }}"

# Check if key exists
puts "Has name? #{person.key?(:name)}"
puts "Has :country? #{person.key?(:country)}"

puts "\n=== Modifying Hashes ==="

# Adding/updating values
person[:email] = 'alice@example.com'
person[:age] = 31
puts "After update: #{person}"

# Merge hashes
additional_info = { country: 'USA', phone: '555-1234' }
merged = person.merge(additional_info)
puts "Merged: #{merged}"

# Delete keys
person.delete(:email)
puts "After delete: #{person}"

# Compact (remove nil values)
sparse = { a: 1, b: nil, c: 3 }
puts "Before compact: #{sparse}"
puts "After compact: #{sparse.compact}"

puts "\n=== Iterating ==="

person = { name: 'Alice', age: 30, city: 'NYC', country: 'USA' }

# Iterate over key-value pairs
puts 'Key-value pairs:'
person.each do |key, value|
  puts "  #{key}: #{value}"
end

# Iterate over keys only
puts "\nKeys:"
person.each_key { |key| puts "  #{key}" }

# Iterate over values only
puts "\nValues:"
person.each_value { |value| puts "  #{value}" }

# With index
puts "\nWith index:"
person.each_with_index { |(key, value), index| puts "  #{index}: #{key}=#{value}" }

puts "\n=== Common Methods ==="

scores = { alice: 95, bob: 82, charlie: 88, diana: 92 }

# Keys and values
puts "Keys: #{scores.keys}"
puts "Values: #{scores.values}"

# Size
puts "Size: #{scores.size}"
puts "Empty? #{scores.empty?}"

# Sort
puts "Sorted by name: #{scores.sort}"
puts "Sorted by score (desc): #{scores.sort_by { |_, v| -v }}"

# Select/Reject
puts "Passing scores (>85): #{scores.select { |_, v| v > 85 }}"
puts "Failing scores (<85): #{scores.reject { |_, v| v > 85 }}"

# Map (transform)
puts "All passing: #{scores.map { |k, v| k if v >= 85 }.compact}"

# Merge! (destructive)
h1 = { a: 1, b: 2 }
h2 = { b: 3, c: 4 }
h1.merge!(h2)
puts "After merge!: #{h1}"

puts "\n=== Practical Examples ==="

# Counting occurrences
words = %w[apple banana apple cherry banana apple]
counts = Hash.new(0)
words.each { |word| counts[word] += 1 }
puts "Word counts: #{counts}"

# Grouping
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
grouped = numbers.group_by { |n| n.even? ? 'even' : 'odd' }
puts "Grouped by parity: #{grouped}"

# Inverting
scores = { alice: 95, bob: 82 }
inverted = scores.invert
puts "Inverted: #{inverted}"

# Default value for missing keys
inventory = Hash.new(0)
inventory[:apples] += 5
inventory[:oranges] += 3
puts "Inventory: #{inventory}"

# Nested hash
database = {
  users: {
    alice: { email: 'alice@test.com', role: 'admin' },
    bob: { email: 'bob@test.com', role: 'user' },
  },
}
puts "Nested access: #{database[:users][:alice][:email]}"

puts "\n=== Advanced Methods ==="

# Slice (get subset)
person = { name: 'Alice', age: 30, city: 'NYC', country: 'USA', email: 'a@t.com' }
puts "Sliced: #{person.slice(:name, :email)}"

# Transform keys/values
transformed = person.transform_keys { |k| k.to_s.upcase }
puts "Transformed keys: #{transformed}"

transformed = person.transform_values { |v| v.to_s }
puts "Transformed values: #{transformed}"

# Dig (safe nested access)
data = { user: { address: { city: 'NYC' } } }
puts "Dig: #{data.dig(:user, :address, :city)}"
puts "Dig missing (with fallback): #{data.dig(:user, :address, :zip) || 'N/A'}"
