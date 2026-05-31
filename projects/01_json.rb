#!/usr/bin/env ruby
# frozen_string_literal: true

# 01_json.rb — JSON.parse vs JSON.generate: Ruby ↔ JSON
#
# WITHOUT JSON — hand-rolled parsing that breaks on edge cases:
#
#   raw = '{"deploy": true, "region": "us-east-1"}'
#   raw.scan(/"(\w+)":\s*(\S+)/)  # breaks on nested objects, arrays, escapes
#
# WITH JSON — one call, all edge cases handled:

require "json"

# Parse: JSON string → Ruby Hash
payload = '{"service":"api","replicas":3,"regions":["us-east-1","eu-west-1"]}'
config = JSON.parse(payload)
puts "Service:  #{config["service"]}"
puts "Replicas: #{config["replicas"]}"
puts "First region: #{config["regions"].first}"
# Keys are strings by default. Use symbolize_names: true for symbols:
# JSON.parse(payload, symbolize_names: true) → {service: "api", ...}

# Generate: Ruby Hash → JSON string
deploy = {
  env: "production",
  version: "3.2.1",
  dry_run: false,
  tags: ["hotfix", "urgent"]
}
puts "\nGenerated JSON:"
puts JSON.pretty_generate(deploy)
# => {
#      "env": "production",
#      "version": "3.2.1",
#      "dry_run": false,
#      "tags": ["hotfix", "urgent"]
#    }

# JSON.generate is the compact version. pretty_generate is for humans.
# Both handle nesting, escaping, and type conversion correctly.
#
# Custom objects need #to_json or a block:
#   JSON.generate(obj) { |o| o.to_h.to_json }
