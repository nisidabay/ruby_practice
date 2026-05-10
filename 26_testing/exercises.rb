#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — MiniTest: write tests for a simple class

require "minitest/autorun"

# --- Class under test ---
class Calculator
  def add(a, b)
    a + b
  end

  def divide(a, b)
    raise ArgumentError, "Cannot divide by zero" if b.zero?
    a.to_f / b
  end
end

# --- Tests ---
class CalculatorTest < Minitest::Test
  def setup
    @calc = Calculator.new
  end

  def test_add
    assert_equal 7, @calc.add(3, 4)
    assert_equal 0, @calc.add(-1, 1)
  end

  def test_divide
    assert_in_delta 2.5, @calc.divide(5, 2), 0.001
  end

  def test_divide_by_zero_raises
    assert_raises(ArgumentError) { @calc.divide(10, 0) }
  end

  # --- BONUS: Add a test for multiplication ---
  # def test_multiply
  #   # your assertion here
  # end
end
