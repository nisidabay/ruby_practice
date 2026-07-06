#!/usr/bin/env ruby
# frozen_string_literal: true

# 01_current_time.rb — Get the current date and time with Time.now

now = Time.now
puts now                         # => 2026-05-08 08:07:37 +0200

today = Time.new                 # Same as Time.now
puts today                       # => 2026-05-08 08:07:37 +0200

# Thinking in Ruby
#
# Time.now and Time.new are synonymous — Ruby gives you two ways to say
# the same thing because readability matters. Time.now reads like English
# ("get the time now"), while Time.new signals "I'm constructing a Time
# object, possibly with arguments." Having both means your code can say
# exactly what you mean. The default to_s format (ISO-like with timezone)
# is designed for human reading, not machine parsing — a deliberate choice.
