#!/usr/bin/env ruby
# frozen_string_literal: true

# Documentation Header Adder
# Adds consistent Ruby documentation headers to Ruby files

require 'fileutils'

def add_documentation_header(file_path)
  puts "Documenting: #{file_path}"

  # Read the file content
  content = File.read(file_path)

  # Skip if already has documentation-style comment
  return if content =~ /^# This file .*/ || content =~ /^# Description: /

  # Extract file name and base name
  file_name = File.basename(file_path, '.rb')

  # Generate header based on file name
  header = generate_header(file_name)

  # Insert header after shebang line
  lines = content.lines
  has_shebang = lines.first && lines.first.start_with?('#!/usr/bin/env ruby')

  if has_shebang && lines.length > 1 && lines[1].start_with?('# frozen_string_literal:')
    # Insert after shebang and frozen string literal
    header_lines = header.lines
    new_content = [lines[0], lines[1]] + header_lines + lines[2..-1]
  elsif has_shebang
    # Insert after shebang
    header_lines = header.lines
    new_content = [lines[0]] + header_lines + lines[1..-1]
  else
    # Insert at beginning
    header_lines = header.lines
    new_content = header_lines + lines
  end

  File.write(file_path, new_content.join)
  puts "✓ Documented: #{file_path}"
end

def generate_header(file_name)
  case file_name
  when /factorial/ then factorial_header(file_name)
  when /palindrome/ then palindrome_header(file_name)
  when /fizzbuzz/ then fizzbuzz_header(file_name)
  when /guess.*number/ then guess_number_header(file_name)
  when /contacts/ then contacts_header(file_name)
  when /todo/ then todo_header(file_name)
  when /calculator/ then calculator_header(file_name)
  when /arrays?/ then arrays_header(file_name)
  when /strings?/ then strings_header(file_name)
  when /methods?/ then methods_header(file_name)
  when /oop|classes/ then oop_header(file_name)
  when /control.*flow/ then control_flow_header(file_name)
  else default_header(file_name)
  end
end

def default_header(file_name)
  <<~HEADER
    # #{file_name.gsub('_', ' ').gsub(/.rb$/, '').capitalize}
    # This file contains Ruby code for #{file_name.gsub('_', ' ').gsub(/.rb$/, '')}.

  HEADER
end

def factorial_header(_file_name)
  <<~HEADER
    # Factorial Calculator
    # This file calculates the factorial of a given number using recursion.
    # Demonstrates recursive function calls and accumulator patterns.

  HEADER
end

def palindrome_header(_file_name)
  <<~HEADER
    # Palindrome Checker
    # This file checks if a word or phrase is a palindrome.
    # Demonstrates string manipulation and comparison techniques.

  HEADER
end

def fizzbuzz_header(_file_name)
  <<~HEADER
    # FizzBuzz Implementation
    # Classic FizzBuzz exercise - prints numbers from 1 to n, replacing multiples of 3 with "Fizz",
    # multiples of 5 with "Buzz", and multiples of both with "FizzBuzz".

  HEADER
end

def guess_number_header(_file_name)
  <<~HEADER
    # Number Guessing Game
    # This file implements a simple number guessing game.
    # Demonstrates user input handling and basic game logic.

  HEADER
end

def contacts_header(_file_name)
  <<~HEADER
    # Contacts Management System
    # This file implements a contacts management system with CRUD operations.
    # Demonstrates object-oriented programming and file handling.

  HEADER
end

def todo_header(_file_name)
  <<~HEADER
    # Todo List Manager
    # This file implements a todo list management system.
    # Demonstrates array manipulation and basic CRUD operations.

  HEADER
end

def calculator_header(_file_name)
  <<~HEADER
    # Simple Calculator
    # This file implements basic arithmetic operations.
    # Demonstrates method definitions and mathematical operations.

  HEADER
end

def arrays_header(_file_name)
  <<~HEADER
    # Array Operations
    # This file demonstrates various array operations and methods.
    # Shows enumeration, transformation, and filtering operations.

  HEADER
end

def strings_header(_file_name)
  <<~HEADER
    # String Operations
    # This file demonstrates string manipulation techniques.
    # Shows interpolation, concatenation, and various string methods.

  HEADER
end

def methods_header(_file_name)
  <<~HEADER
    # Method Examples
    # This file demonstrates Ruby method definitions and usage.
    # Shows parameter handling, blocks, and method chaining.

  HEADER
end

def oop_header(_file_name)
  <<~HEADER
    # Object-Oriented Programming Examples
    # This file demonstrates Ruby OOP concepts including classes and modules.
    # Shows inheritance, polymorphism, and encapsulation.

  HEADER
end

def control_flow_header(_file_name)
  <<~HEADER
    # Control Flow Examples
    # This file demonstrates Ruby control flow structures.
    # Shows conditionals, loops, and branching logic.

  HEADER
end

def find_ruby_files(directory = '.')
  ruby_files = []

  Dir.glob(File.join(directory, '**', '*.rb')) do |file|
    # Skip backup folder and the documentation script itself
    next if file.include?('ruby_backup/')
    next if file.include?('add_documentation.rb')
    next if file.include?('format_ruby_files.rb')

    ruby_files << file
  end

  ruby_files
end

def main
  puts 'Ruby Documentation Header Adder'
  puts '=' * 40

  ruby_files = find_ruby_files

  puts "Found #{ruby_files.size} Ruby files to document"
  puts '=' * 40

  ruby_files.each do |file_path|

    add_documentation_header(file_path)
  rescue StandardError => e
    puts "⚠ Error documenting #{file_path}: #{e.message}"

  end

  puts '=' * 40
  puts 'Documentation headers added successfully!'
end

if $PROGRAM_NAME == __FILE__
  main
end
