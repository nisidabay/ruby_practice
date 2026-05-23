#!/usr/bin/env ruby

# From Udemy Course

# Define an calculate_grocery_total method that accepts a string.
# The string describes the goods I purchased at the supermarket
# along with their prices.
#
# The prices will alway be written in the following format:
#   $24.99
#   -> dollar sign
#   -> dollar amount
#   -> single dot
#   -> cent amount
#
# Calculate the total cost of my groceries. Return the value as a
# Define an calculate_grocery_total method that accepts a string.
# The string describes the goods I purchased at the supermarket
# along with their prices.
#
# The prices will alway be written in the following format:
#   $24.99
#   -> dollar sign
#   -> dollar amount
#   -> single dot
#   -> cent amount
#
# Calculate the total cost of my groceries. Return the value as a
# floating-point number.
#
# Examples:
# The => indicates the expected return value
#
# calculate_grocery_total("I purchased 4 apples for $9.99, 3 boxes of strawberries for $19.99, and one box of cereal for $5.49.")
#  => 35.47
# floating-point number.
#
# Examples:
# The => indicates the expected return value
#
# calculate_grocery_total("I purchased 4 apples for $9.99, 3 boxes of strawberries for $19.99, and one box of cereal for $5.49.")
#  => 35.47

def calculate_grocery_total(purchase)
  prices = purchase.scan(/\$(\d+)\.(\d{2})/)

  total_cents = prices.reduce(0) do |sum, (dollars, cents)|
    sum + (dollars.to_i * 100) + cents.to_i
  end

  total_cents / 100.0
end
p calculate_grocery_total('I purchased 4 apples for $9.99, 3 boxes of strawberries for $19.99, and one box of cereal for $5.49.')

def calculate_grocery_total(purchase)
  prices = purchase.scan(/\$(\d+\.\d+)/)
  prices.flatten.reduce(0) { |sum, item| sum + item.to_f }
end
p calculate_grocery_total('I purchased 4 apples for $9.99, 3 boxes of strawberries for $19.99, and one box of cereal for $5.49.')

def calculate_grocery_total(purchase)
  purchase.scan(/\$\d+\.\d+/).map { |price| price.gsub('$', '').to_f }.sum
end
p calculate_grocery_total('I purchased 4 apples for $9.99, 3 boxes of strawberries for $19.99, and one box of cereal for $5.49.')
