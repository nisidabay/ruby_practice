#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_json_config.rb — JSON as config file: load defaults, override from file
require "json"

config_path = "/tmp/ruby_config.json"
defaults = {"host" => "localhost", "port" => 3000, "debug" => false}

config = if File.exist?(config_path)
  defaults.merge(JSON.parse(File.read(config_path)))
else
  defaults
end

puts "Host:  #{config["host"]}"
puts "Port:  #{config["port"]}"
puts "Debug: #{config["debug"]}"

# Thinking in Ruby
#
# JSON config with fallback defaults is a one-liner in Ruby: merge
# the parsed file over your defaults. The built-in json library means
# no gem installs, no schema declarations — just a hash. Ruby treats
# configuration as data, and data as hashes, making the code read
# like the config itself.
