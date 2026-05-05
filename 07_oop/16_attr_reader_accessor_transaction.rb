#!/usr/bin/env ruby
# frozen_string_literal: true

# attr_reader_accessor_transaction.rb — mix read-only + read-write

class FinancialTransaction
  attr_reader :to, :from, :amount
  attr_accessor :completed

  def initialize(to, from, amount, completed)
    @to = to
    @from = from
    @amount = amount
    @completed = completed
  end
end

tx = FinancialTransaction.new("Landlord", "Boris", 1000, false)
puts tx.to, tx.from, tx.amount, tx.completed
tx.completed = true
puts tx.completed

# tx.to = "Someone"  # NoMethodError — attr_reader has no setter

