#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_binding_irb.rb — drop into an interactive REPL mid-execution
#
# WITHOUT binding.irb — you add puts everywhere and re-run:
#
#   puts "config=#{config.inspect}"
#   puts "user=#{user.inspect}"    # re-run every time you change what to inspect
#
# WITH binding.irb — you get a live REPL where execution paused:

require "irb"

config = {host: "db.internal", port: 5432, pool: 10}
user    = {name: "Carlos", role: "admin"}

# binding.irb pauses here. At the prompt type:
#   config[:port]    # => 5432
#   user.keys        # => [:name, :role]
#   config[:pool] = 20   # modify live!
#   exit             # resume execution
#
# binding.irb  # uncomment to try — commented so this file runs clean
# (Ruby 3.4+: require "irb" first — irb was removed from default gems)

puts "After IRB: config=#{config.inspect}"  # changes you made in IRB persist

# binding.irb is heavier than binding.break (debug gem) — it's a full Ruby REPL.
# Use when you want to explore objects, not just step through code.
