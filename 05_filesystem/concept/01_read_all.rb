#!/usr/bin/env ruby
# frozen_string_literal: true

# 01_read_all.rb — File.read: open, slurp, close in one call
#
# WITHOUT File.read — three lines every time:
#
#   f = File.open("config.yml")
#   content = f.read
#   f.close
#
# WITH File.read — same thing, one line:

require 'tempfile'

Tempfile.create(['config', '.yml']) do |tmp|
  tmp.write("host: localhost\nport: 5432\n")
  tmp.rewind

  partial = File.read(tmp.path, 14) # first 14 bytes only
  puts partial.inspect # => "host: localhos"  (14 bytes, 't' cut off)

  full = File.read(tmp.path) # no limit = entire file
  puts full # => host: localhost
  #    port: 5432
end

# Pathname alias — same thing with an object-oriented API:
#   require "pathname"
#   Pathname.new("config.yml").read

# Thinking in Ruby
#
# File.read is a perfect example of Ruby's "convention over ceremony" philosophy.
# Other languages need you to open, allocate a buffer, read, close, check errors.
# Ruby gives you File.read — one call, one return value, zero ceremony.
# The idiom is so clean that you reach for it before you think about edge cases.
