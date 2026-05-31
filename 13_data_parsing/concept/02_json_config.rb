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
