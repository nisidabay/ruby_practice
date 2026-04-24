#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want class methods that create preset instances and track global state.
# Example: SushiLunchOrder.salmon_special creates a preset order, track total fish sold.
#
# Solution: Combine class methods (def self.method) with class variables (@@total).
# Visibility: PUBLIC class methods, PRIVATE class variable (exposed via getter).

class SushiLunchOrder
  attr_reader :salmon, :tuna, :yellowtail

  # Class variable tracks total fish across ALL instances
  @@total_pieces = 0

  def initialize(salmon, tuna, yellowtail)
    @salmon = salmon
    @tuna = tuna
    @yellowtail = yellowtail
    @@total_pieces += count_pieces
  end

  def count_pieces
    @salmon + @tuna + @yellowtail
  end

  # Class methods create preset orders
  class << self
    def salmon_special
      new(6, 3, 3)
    end

    def family_combo
      new(12, 12, 12)
    end

    def total_pieces
      @@total_pieces
    end
  end
end

# Usage: Class methods create instances, class variable tracks global total
order1 = SushiLunchOrder.salmon_special
puts "Salmon: #{order1.salmon}, Tuna: #{order1.tuna}, Yellowtail: #{order1.yellowtail}"
puts "Total pieces sold: #{SushiLunchOrder.total_pieces}"

order2 = SushiLunchOrder.family_combo
puts "\nSalmon: #{order2.salmon}, Tuna: #{order2.tuna}, Yellowtail: #{order2.yellowtail}"
puts "Total pieces sold: #{SushiLunchOrder.total_pieces}"

order3 = SushiLunchOrder.new(3, 4, 5)
puts "\nSalmon: #{order3.salmon}, Tuna: #{order3.tuna}, Yellowtail: #{order3.yellowtail}"
puts "Total pieces sold: #{SushiLunchOrder.total_pieces}"

# This could also be done like this:
# Use a class instance variable instead of @@ class variable:
#
# class SushiLunchOrder
#   @total_pieces = 0
#
#   def self.total_pieces
#     @total_pieces
#   end
#
#   def initialize(...)
#     @class.instance_variable_set(:@total_pieces, @total_pieces + count_pieces)
#   end
# end
