#!/usr/bin/env ruby
# frozen_string_literal: true

# hashes.rb — Hash basics and common patterns

# Creation
h = {}
h = { name: 'Alice', age: 30 }
h = Hash.new(0)                    # default value for missing keys
h = Hash.new { |hash, key| hash[key] = [] }  # default with block

# Access
person = { name: 'Alice', age: 30, city: 'NYC' }
puts person[:name]                 # => Alice
puts person.fetch(:country, 'USA') # => USA (default if key missing)
puts person.key?(:name)            # => true
puts person.key?(:country)         # => false

# Modify
person[:email] = 'a@example.com'   # add
person[:age] = 31                  # update
person.delete(:email)              # remove
p person

# Merge
h = { a: 1, b: 2 }.merge(b: 3, c: 4)  # => {a:1, b:3, c:4}
{ a: 1, b: 2 }.merge!(b: 3)            # destructive merge

# Iteration
person.each { |k, v| puts "#{k}: #{v}" }
person.each_key { |k| puts k }
person.each_value { |v| puts v }

# Keys/Values/Size
puts person.keys, person.values, person.size

# Select/Reject
scores = { alice: 95, bob: 82, charlie: 88 }
p scores.select { |k, v| v > 85 }   # passing
p scores.reject { |k, v| v > 85 }   # failing

# Transform
p person.transform_keys { |k| k.to_s.upcase }
p person.transform_values { |v| v.to_s }

# Sort
p scores.sort                        # by key
p scores.sort_by { |k, v| -v }      # by value descending

# Counting (classic pattern)
words = %w[apple banana apple cherry banana apple]
counts = Hash.new(0)
words.each { |w| counts[w] += 1 }
p counts  # => {"apple"=>3, "banana"=>2, "cherry"=>1}

# Group by
p (1..10).group_by { |n| n.even? ? 'even' : 'odd' }

# Invert, Slice, Dig
p scores.invert
p person.slice(:name, :age)
data = { user: { address: { city: 'NYC' } } }
p data.dig(:user, :address, :city)  # => "NYC"
p data.dig(:user, :address, :zip) || 'N/A'  # => "N/A"


# Thinking in Ruby
#
# Ruby hashes preserve insertion order (since Ruby 1.9), can use any
# object as a key, and support default values via Hash.new(default) or
# Hash.new { |h, k| h[k] = [] }. The transform_keys/transform_values
# methods provide batch mutation, and dig() navigates nested hashes
# without nil errors.
