#!/usr/bin/env ruby
# frozen_string_literal: true

# 01_attr_accessor_basic.rb — auto-generate getters/setters

# WITHOUT attr_accessor — 6 lines of boilerplate per attribute:
#
#   class Order
#     def total
#       @total
#     end
#     def total=(value)
#       @total = value
#     end
#     # repeat for status, customer...
#   end
#
# WITH attr_accessor — one line:

class Order
  attr_accessor :total, :status

  def summary
    "#{@status} order: $#{@total}"
  end
end

order = Order.new
order.total = 149.99
order.status = :pending
puts order.summary  # => pending order: $149.99

# attr_accessor has NO validation — anything gets through:
order.total = -50   # silently accepted (bad!)
puts order.summary  # => pending order: $-50

# Thinking in Ruby
#
# attr_accessor is Ruby's declaration of intent: one line replaces six
# lines of getter/setter boilerplate. But it's naive — no validation,
# no guards. Ruby gives you the shortcut AND the escape hatch (custom
# setters). This reflects Ruby's philosophy: fast path first, full
# control when you need it.
