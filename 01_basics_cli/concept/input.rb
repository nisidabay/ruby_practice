#!/usr/bin/env ruby
# frozen_string_literal: true

# input.rb — gets reads from the terminal (or STDIN pipe)

# Interactive: ruby input.rb  →  type and press Enter
# Piped:      echo "db.internal" | ruby input.rb

# "&" validate the "gets" command from being empty before "chomping it"
host = $stdin.gets&.chomp || 'localhost'
port = $stdin.gets&.chomp || '5432'

puts "Connecting to #{host}:#{port}..."
