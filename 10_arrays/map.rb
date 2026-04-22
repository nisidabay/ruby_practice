#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Map
# This file contains Ruby code for map.

# use of map/collect

names = %w[Alice Bob Steve Alison]
p names
upper_names = names.map { |name| name.upcase }
p upper_names

downcase_names = names.collect { |name| name.downcase }
p downcase_names

numbers = [1, 2, 3, 4, 5]

# Square each number
squared = numbers.map { |n| n * n }
p squared # => [1, 4, 9, 16, 25]

# Double each number
doubled = numbers.collect { |n| n * 2 }
p doubled # => [2, 4, 6, 8, 10]

users = [
  { name: 'Alice', age: 25 },
  { name: 'Bob', age: 30 },
  { name: 'Charlie', age: 35 },
]

# Get all names
names = users.map { |user| user[:name] }
p names # => ["Alice", "Bob", "Charlie"]

# Get all ages
ages = users.collect { |user| user[:age] }
p ages # => [25, 30, 35]

## Using `&:` Symbol-to-Proc (Shorthand)
## Ruby allows a shorthand syntax when calling a single method:

fruits = %w[apple banana cherry]

# Long form
long = fruits.map { |fruit| fruit.upcase }
p long # => ["APPLE", "BANANA", "CHERRY"]

# Short form
short = fruits.map(&:upcase)
p short # => ["APPLE", "BANANA", "CHERRY"]

numbers = [1, 2, 3, 4]
p numbers.map(&:odd?)   # => [true, false, true, false]
p numbers.map(&:to_s)   # => ["1", "2", "3", "4"]

## Transforming into Hashes
keys = %i[a b c]
values = [1, 2, 3]

# Combine two arrays into a hash
hash = keys.zip(values).map { |key, value| [key, value] }.to_h
p hash # => {:a=>1, :b=>2, :c=>3}

## Using with Ranges

# Generate squares for numbers 1 to 5
squares = (1..5).map { |n| n**2 }
p squares # => [1, 4, 9, 16, 25]

# Create a list of strings
letters = ('a'..'e').map { |char| char * 3 }
p letters # => ["aaa", "bbb", "ccc", "ddd", "eee"]

## Conditional Transformation

numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Replace even numbers with "even", odd with "odd"
result = numbers.map { |n| n.even? ? 'even' : 'odd' }
p result # => ["odd", "even", "odd", "even", "odd", "even", "odd", "even", "odd", "even"]

# Multiply only numbers greater than 5
filtered = numbers.map { |n| n > 5 ? n * 10 : n }
p filtered # => [1, 2, 3, 4, 5, 60, 70, 80, 90, 100]

## Chaining with Other Methods

words = %w[hello world ruby]

# Chain map and select (filter)
result = words.map(&:upcase).select { |w| w.length > 4 }
p result # => ["HELLO", "WORLD"]

# Chain with join
sentence = %w[I love coding].map(&:capitalize).join(' ')
p sentence # => "I Love Coding"

## Nested Arrays

matrix = [[1, 2], [3, 4], [5, 6]]

# Flatten and double
doubled_flat = matrix.flatten.map { |n| n * 2 }
p doubled_flat # => [2, 4, 6, 8, 10, 12]

# Keep nested structure but transform
transposed = matrix.map { |row| row.map { |n| n * 2 } }
p transposed # => [[2, 4], [6, 8], [10, 12]]
