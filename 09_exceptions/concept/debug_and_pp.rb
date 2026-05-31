#!/usr/bin/env ruby
# frozen_string_literal: true

# debug_and_pp.rb — inspect deeply nested objects, set breakpoints
require "pp"

# pp: pretty print complex structures
nested = {
  server: {host: "nuc", ips: %w[10.0.0.1 10.0.0.2]},
  database: {host: "db.internal", port: 5432, pool: {min: 2, max: 8}},
  workers: 4
}
pp nested

# debugger: Ruby 3.1+ bundled debug gem
# require "debug"    # uncomment to use
# binding.break      # place this in code to start an interactive debug session
puts "\n→ Uncomment `require 'debug'` and add `binding.break` to step through code"
