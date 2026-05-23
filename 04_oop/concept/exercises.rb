#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — OOP: classes, inheritance, modules

# --- Create a Book class with title, author, and a describe method ---
# class Book
#   attr_reader :title, :author
#   def initialize(title, author)
#     # your code
#   end
#   def describe
#     # your code — return a string
#   end
# end
# b = Book.new("1984", "George Orwell")
# puts b.describe  # => "1984 by George Orwell"

# --- Inherit Ebook from Book, add a format field ---
# class Ebook < Book
#   attr_reader :format
#   def initialize(title, author, format)
#     # your code — call super first
#   end
# end
# eb = Ebook.new("Dune", "Frank Herbert", "epub")
# puts eb.describe  # => "Dune by Frank Herbert [epub]"

# --- Mixin: create a Loggable module and include it in a class ---
# module Loggable
#   def log(msg)
#     puts "[LOG] #{msg}"
#   end
# end
# class OrderProcessor
#   include Loggable
#   def process(order_id)
#     log("Processing order ##{order_id}")
#   end
# end
# OrderProcessor.new.process(42)

# --- BONUS: Make a class method that counts instances ---
# Hint: use a @@class_variable
