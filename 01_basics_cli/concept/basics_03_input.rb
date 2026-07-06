#!/usr/bin/env ruby
# frozen_string_literal: true

# input.rb — gets reads from the terminal (or STDIN pipe)

# Interactive: ruby input.rb  →  type and press Enter
# Piped:      echo "db.internal" | ruby input.rb

# "&" validate the "gets" command from being empty before "chomping it"

host = $stdin.gets&.chomp || 'localhost'
port = $stdin.gets&.chomp || '5432'

puts "Connecting to #{host}:#{port}..."

# Use ARGF instead of $stdin
host = ARGF.gets&.chomp || 'localhost'
port = ARGF.gets&.chomp || '5432'

puts "Connecting to #{host}:#{port}..."

# Thinking in Ruby
#
# gets/$stdin and ARGF give Ruby scripts dual-mode I/O: piped or interactive
# with zero config. The &. safe-navigation operator (Ruby 2.3+) makes nil-
# handling ergonomic — chomp once, fall back to defaults, no boilerplate.
