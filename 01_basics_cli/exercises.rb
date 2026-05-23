#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — CLI argument parsing practice
#
# Run me: ruby exercises.rb --verbose --count 5 file1 file2
# Edit the sections below to complete each exercise.

require 'optparse'

options = {
  verbose: false,
  count: 1,
  name: nil
}

parser = OptionParser.new do |opts|
  opts.banner = "exercises.rb [options]"

  opts.on("-v", "--verbose", "Enable verbose mode") do
    options[:verbose] = true
  end

  opts.on("-c", "--count N", Integer, "Number of iterations") do |n|
    options[:count] = n
  end

  opts.on("-n", "--name NAME", String, "Your name") do |s|
    options[:name] = s
  end
end.parse!

# === Exercise 1: Print parsed options ===
puts "=== Exercise 1: Options ==="
# --- your code here ---
# HINT: print options[:verbose], options[:count], options[:name]

# === Exercise 2: Process remaining ARGV ===
puts "\n=== Exercise 2: Remaining args ==="
# --- your code here ---
# HINT: ARGV now contains only positional arguments after OptionParser consumed flags
# Print each one with its index

# === Exercise 3: Count iterations ===
puts "\n=== Exercise 3: Iterations ==="
# --- your code here ---
# HINT: options[:count].times { |i| puts "Iteration #{i + 1}" }

# === Exercise 4: Conditional output ===
puts "\n=== Exercise 4: Conditional ==="
if options[:name]
  # --- your code here ---
  # HINT: puts greeting using options[:name]
end

if options[:verbose]
  # --- your code here ---
  # HINT: puts verbose message
end
