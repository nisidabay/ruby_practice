#!/usr/bin/env ruby
# frozen_string_literal: true

# 01_current_time.rb — Get the current date and time with Time.now

now = Time.now
puts now                         # => 2026-05-08 08:07:37 +0200

today = Time.new                 # Same as Time.now
puts today                       # => 2026-05-08 08:07:37 +0200
