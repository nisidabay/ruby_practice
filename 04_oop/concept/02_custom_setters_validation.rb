#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_custom_setters_validation.rb — custom setters with validation

# WITHOUT custom setters — attr_accessor accepts anything:
#
#   class Order
#     attr_accessor :total, :status
#   end
#   order.total = -50  # silently accepted, silently wrong
#
# WITH custom setters — validate on write, reject bad data:

class Order
  attr_reader :total, :status

  def total=(value)
    raise "Total must be positive, got #{value}" unless value.is_a?(Numeric) && value.positive?
    @total = value
  end

  def status=(value)
    valid = %i[pending shipped delivered cancelled]
    raise "Invalid status: #{value}" unless valid.include?(value)
    @status = value
  end

  def summary
    "#{@status} order: $#{@total}"
  end
end

order = Order.new
order.total = 149.99
order.status = :pending
puts order.summary  # => pending order: $149.99
