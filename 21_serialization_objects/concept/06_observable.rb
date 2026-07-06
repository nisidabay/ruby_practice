#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Notify multiple objects when something changes — without tight coupling.
# Example: A Stock price changes → notify Charts, Alerts, and Logger.
#
# Solution: Observable (stdlib) — mixin that adds observer pattern to any class.
# Visibility: `require 'observer'`. Include Observable, call changed + notify_observers.

require 'observer'

# The subject — something that changes
class Stock
  include Observable

  attr_reader :price

  def initialize(symbol, price)
    @symbol = symbol
    @price = price
  end

  def price=(new_price)
    return if new_price == @price
    @price = new_price
    changed                 # mark that state changed
    notify_observers(self)  # tell all observers
  end
end

# Observers — react to changes
class Chart
  def update(stock)
    puts "[Chart] #{stock.price} — redrawing..."
  end
end

class Alert
  def update(stock)
    puts "[Alert] Price changed!" if stock.price > 100
  end
end

stock = Stock.new('RUBY', 95)
stock.add_observer(Chart.new)
stock.add_observer(Alert.new)

stock.price = 105
# => [Chart] 105 — redrawing...
# => [Alert] Price changed!

# This could also be done like this:
# Manual callbacks (tight coupling):
#
#   class Stock
#     def price=(new_price)
#       @price = new_price
#       @chart.redraw(self)     # knows about Chart!
#       @alert.check(self)      # knows about Alert!
#     end
#   end
#
# Observable decouples the subject from observers — add/remove them freely.
#
# Thinking in Ruby
#
# Ruby's Observable mixin brings the Observer pattern to any class with a single
# include. The `changed` + `notify_observers` two-step protocol is intentionally
# explicit — you must mark state as changed before notifying, giving you control
# over when notifications fire. This design reflects Ruby's preference for
# explicit over implicit: the mixin gives you the mechanism, but you decide
# when and how to use it.
