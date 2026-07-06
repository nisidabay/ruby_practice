#!/usr/bin/env ruby
# frozen_string_literal: true

# 04_yaml_config.rb — YAML for human-readable config files
require "yaml"

config = YAML.safe_load(<<~YAML)
  database:
    host: db.internal
    port: 5432
  workers: 4
  enabled: true
YAML

puts "DB host: #{config["database"]["host"]}"
puts "Workers: #{config["workers"]}"
puts "Enabled: #{config["enabled"]}"

# Thinking in Ruby
#
# YAML.safe_load converts human-readable config into a Ruby hash in
# one call. No parsing library configuration needed — require "yaml"
# and you're done. Ruby's YAML integration is so seamless that config
# files feel like native Ruby data, not external formats.
