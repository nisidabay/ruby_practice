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

# Thinking in Ruby
#
# map (collect) transforms every element via a block — the simplest
# expression of the "transform each" pattern. Ruby's Symbol#to_proc
# (&:upcase) makes common transformations a single character: the block
# call. No lambda syntax, no pipeline operators — just a method and a
# block.
