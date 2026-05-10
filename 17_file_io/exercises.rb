#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Read and write files

# --- Write a shopping list to a file ---
items = ["apples", "bananas", "coffee", "eggs"]
File.open("shopping.txt", "w") do |f|
  items.each { |item| f.puts "- #{item}" }
end

# --- Read it back line by line ---
File.foreach("shopping.txt") { |line| puts line.strip }

# --- Read the whole file at once ---
content = File.read("shopping.txt")
puts "\nWhole file:"
puts content

# --- Clean up ---
File.delete("shopping.txt")

# --- BONUS: Count lines, words, and characters in a text file ---
# text = File.read("exercises.rb")
# puts "Lines: #{text.lines.count}"
# puts "Words: #{text.split.size}"
# puts "Chars: #{text.length}"
