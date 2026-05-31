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
