#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to restrict what values can be assigned to attributes.
# Example: Product name must be 3-20 chars, price must be positive.
#
# Solution: Use attr_reader and define custom setter methods with validation.
# Visibility: PUBLIC read access, validated write access.

class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def name=(name)
    if name.length.between?(3, 20)
      @name = name
    else
      @name = "TBD"
    end
  end

  def price=(price)
    @price = price if price > 0
  end
end

# Usage: Setters validate before assigning
book = Product.new("1984", 9.99)
puts book.name

book.name = "Harry Potter"
puts book.name

book.name = "OK"  # Too short
puts book.name   # "TBD"

puts book.price

book.price = 24.99
puts book.price

book.price = -100  # Invalid
puts book.price    # Still 24.99

# This could also be done like this:
# Raise errors instead of silent defaults:
#
# def name=(name)
#   raise "Name must be 3-20 chars" unless name.length.between?(3, 20)
#   @name = name
# end
