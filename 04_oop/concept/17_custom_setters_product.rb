#!/usr/bin/env ruby
# frozen_string_literal: true

# custom_setters_product.rb — validated write access

class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def name=(name)
    @name = name.length.between?(3, 20) ? name : "TBD"
  end

  def price=(price)
    @price = price if price > 0
  end
end

book = Product.new("1984", 9.99)
puts book.name
book.name = "OK"       # too short → "TBD"
puts book.name
book.price = -100       # invalid, ignored
puts book.price          # still 9.99

