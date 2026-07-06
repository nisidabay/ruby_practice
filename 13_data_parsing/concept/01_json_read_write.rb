#!/usr/bin/env ruby
# frozen_string_literal: true

# 01_json_read_write.rb — read and write JSON with the built-in json library
require "json"

data = {"name" => "Carlos", "os" => "Arch", "tools" => %w[nvim tmux kitty]}
File.write("/tmp/ruby_learn.json", JSON.pretty_generate(data))

loaded = JSON.parse(File.read("/tmp/ruby_learn.json"))
puts "Name: #{loaded["name"]}"
puts "OS:   #{loaded["os"]}"
puts "Tools: #{loaded["tools"].join(", ")}"

# Thinking in Ruby
#
# JSON.pretty_generate produces readable output and JSON.parse restores
# it back to a hash — no mapping, no boilerplate. Ruby's json library
# is built into stdlib because JSON is Ruby data: hashes, arrays,
# strings, numbers, booleans. Write a hash, read a hash. The format
# is just serialization, not a different world.
