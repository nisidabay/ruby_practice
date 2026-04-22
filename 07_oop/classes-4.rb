#!/usr/bin/env ruby
# frozen_string_literal: true

# Object-Oriented Programming Examples
# This file demonstrates Ruby OOP concepts including:
# - Class definition and initialization
# - Instance variables and attribute accessors
# - Method definitions and String methods (chomp)
# - Overriding the to_s method for custom string representation

# The Chomp class provides methods to manipulate a string by removing trailing
# newline characters.
class Chomp
  attr_accessor :word

  # Initializes a new Chomp object with the given word.
  # Prints the length of the word.
  #
  # @param word [String] the word to be manipulated
  def initialize(word)
    @word = word
    puts "The length of #{@word} is #{@word.size}"
  end

  # Removes trailing newline characters from the word.
  # Updates the word and prints its new length.
  def remove_spaces
    @word = @word.chomp
    puts "The length of #{@word} is now #{@word.size}"
  end

  # Returns a string representation of the current word.
  # Overrides the default to_s method for custom output.
  def to_s
    "The word you're working with is now #{@word}"
  end
end

# Example usage of the Chomp class
test = Chomp.new("Carlos\n")
test.remove_spaces
test.word = "Sergio\n"
p "Changing the instance variable to #{test.word}"
test.remove_spaces
