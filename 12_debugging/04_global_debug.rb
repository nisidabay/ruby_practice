#!/usr/bin/env ruby
# frozen_string_literal: true

# 04_global_debug.rb — $DEBUG flag: conditional debug output without changing code
#
# WITHOUT $DEBUG — you comment/uncomment puts statements:
#
#   # puts "Processing #{file}"    # commented for production
#   # uncomment for debugging, re-comment after — tedious
#
# WITH $DEBUG — one switch toggles all debug output:

$DEBUG = true  # try setting to false

def process_order(id, items)
  puts "[DEBUG] process_order(#{id}, #{items.size} items)" if $DEBUG

  total = items.sum { |item| item[:price] * item[:qty] }
  puts "[DEBUG] total=#{total}" if $DEBUG

  "Order ##{id}: $#{total}"
end

order = process_order(4291, [
  {name: "widget",  price: 9.99,  qty: 3},
  {name: "gadget",  price: 14.50, qty: 1}
])
puts order

# Ruby sets $DEBUG when you run with -d flag:
#   ruby -d script.rb     → $DEBUG is true
#   ruby script.rb        → $DEBUG is false
# No code changes needed — the flag toggles debug output.

# Alternative: $VERBOSE (-w flag) for warnings
#   ruby -w script.rb: $VERBOSE is true (shows warnings from Ruby itself)
