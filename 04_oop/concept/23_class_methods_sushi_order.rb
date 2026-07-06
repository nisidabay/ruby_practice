#!/usr/bin/env ruby
# frozen_string_literal: true

# class_methods_sushi_order.rb — class methods + class variable

class SushiLunchOrder
  attr_reader :salmon, :tuna, :yellowtail
  @@total_pieces = 0

  def initialize(salmon, tuna, yellowtail)
    @salmon = salmon
    @tuna = tuna
    @yellowtail = yellowtail
    @@total_pieces += @salmon + @tuna + @yellowtail
  end

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

o1 = SushiLunchOrder.salmon_special
o2 = SushiLunchOrder.family_combo
o3 = SushiLunchOrder.new(3, 4, 5)

puts "Total pieces sold: #{SushiLunchOrder.total_pieces}"  # => 57


# Thinking in Ruby
#
# Factory class methods (salmon_special, family_combo) encapsulate
# common instance configurations. Combined with @@ class variables for
# shared state (total_pieces), they show how class-level methods and
# instance-level data interact. The class << self block groups all class
# methods under one syntactic roof.
