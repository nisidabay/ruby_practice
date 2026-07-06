#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_assert_raises.rb — assert_raises: test that the RIGHT error is raised
#
# WITHOUT assert_raises — manual begin/rescue:
#
#   begin; withdraw(200); rescue => e; assert_equal "Insufficient", e.message; end
#   # verbose, error-prone, test passes if NO exception is raised (bad)
#
# WITH assert_raises — the test fails if the exception isn't raised:

require "minitest/autorun"

class InsufficientFunds < StandardError; end

class Account
  def initialize(balance); @balance = balance; end

  def withdraw(amount)
    raise InsufficientFunds, "tried #{amount}, have #{@balance}" if amount > @balance
    @balance -= amount
  end
end

class AccountTest < Minitest::Test
  def test_withdraw_raises_on_overdraft
    acc = Account.new(100)

    error = assert_raises(InsufficientFunds) do
      acc.withdraw(200)
    end

    assert_match(/tried 200/, error.message)
    assert_match(/have 100/, error.message)
  end

  def test_withdraw_does_not_raise_when_valid
    acc = Account.new(100)
    acc.withdraw(50)  # should NOT raise — test passes if no exception
    assert true       # reached = ok (or assert_equal 50, acc.balance)
  end
end

# assert_raises(*exception_classes) returns the exception object.
# The test FAILS if the block doesn't raise one of the expected classes.
# assert_raises(InsufficientFunds) { acc.withdraw(50) }  # → FAIL (no raise)

# Thinking in Ruby
#
# assert_raises turns Ruby's exception system into a testing asset.
# Where other languages require try/catch scaffolding, Minitest
# makes error-path testing declarative. The returned exception
# object lets you verify the message too — no manual rescue blocks needed.
