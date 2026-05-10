#!/usr/bin/env ruby
# frozen_string_literal: true

# map.rb — transform every element (aka collect)

# WITHOUT map — build the array yourself:
#
#   logs = ["ERROR db", "INFO ok", "ERROR auth"]
#   filtered = []
#   logs.each { |l| filtered << l.upcase }
#   # manual push in a loop — works but noisy
#
# WITH map — one call:

logs = ["ERROR db timeout", "INFO health check", "ERROR auth failure"]
p logs.map(&:upcase)  # => ["ERROR DB TIMEOUT", "INFO HEALTH CHECK", "ERROR AUTH FAILURE"]
