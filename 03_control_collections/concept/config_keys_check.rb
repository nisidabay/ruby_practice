#!/usr/bin/env ruby
# frozen_string_literal: true

# config_keys_check.rb — Hash keys as Set: find missing required keys with subtraction
required = %i[host port timeout]
config = {host: "db.internal", port: 5432}

missing = required - config.keys
if missing.any?
  puts "Missing config keys: #{missing.join(", ")}"
else
  puts "All required keys present"
end

# Thinking in Ruby
#
# Array subtraction (required - config.keys) acts as a set difference on
# arrays, finding missing keys without explicit iteration. Combined with
# Hash#keys, this is a concise validation pattern: declare requirements
# as an array, subtract what's present, check if anything remains.
