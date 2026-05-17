#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_custom_exceptions.rb — define your own error classes under StandardError
#
# WITHOUT custom exceptions — you raise RuntimeError with a string and
# the caller can only rescue StandardError (too broad) or parse the message:
#
#   raise "Invalid product code: #{code}"   # caller must match on string text
#
# WITH custom exceptions — the class itself tells you what went wrong:

class ProductNotFound < StandardError
  attr_reader :code

  def initialize(code)
    @code = code
    super("Product not found: #{code}")
  end
end

class InsufficientStock < StandardError
  attr_reader :product, :requested, :available

  def initialize(product:, requested:, available:)
    @product   = product
    @requested = requested
    @available = available
    super("#{product}: asked for #{requested}, only #{available} in stock")
  end
end

# ── Usage ──

def fulfill(product_code, quantity)
  inventory = {"SKU-101" => 5, "SKU-202" => 0}

  raise ProductNotFound.new(product_code) unless inventory.key?(product_code)

  stock = inventory[product_code]
  raise InsufficientStock.new(product: product_code, requested: quantity, available: stock) if stock < quantity

  puts "Fulfilled #{quantity}x #{product_code}"
end

begin
  fulfill("SKU-999", 1)  # doesn't exist
rescue ProductNotFound => e
  puts "⚠️  #{e.class}: #{e.message} (code: #{e.code})"
end

begin
  fulfill("SKU-101", 10) # only 5 in stock
rescue InsufficientStock => e
  puts "⚠️  #{e.class}: #{e.message}"
  puts "   We only have #{e.available}."
end

# The caller can now rescue ProductNotFound separately from InsufficientStock.
# Each error carries structured data (code, requested, available) — no string parsing.
#
# Rule: always inherit from StandardError, NEVER from Exception.
# Exception catches things like SignalException (Ctrl+C) and NoMemoryError
# which you almost never want to trap.
