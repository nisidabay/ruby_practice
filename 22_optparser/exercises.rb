#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — OptionParser: build a CLI with flags and options

require "optparse"

options = { verbose: false, count: 1 }

OptionParser.new do |opts|
  opts.banner = "Usage: ruby exercises.rb [options] NAME"

  opts.on("-v", "--verbose", "Show extra output") do
    options[:verbose] = true
  end

  opts.on("-c", "--count N", Integer, "Repeat N times (default: 1)") do |n|
    options[:count] = n
  end

  opts.on("-h", "--help", "Show this help") do
    puts opts
    exit
  end
end.parse!

name = ARGV.shift || "World"
options[:count].times do
  if options[:verbose]
    puts "Greeting #{name} (verbose mode)"
  else
    puts "Hello, #{name}!"
  end
end

# --- Run these and see what changes ---
# ruby exercises.rb Carlos
# ruby exercises.rb -v Carlos
# ruby exercises.rb -c 3 Carlos
# ruby exercises.rb -v -c 2 Carlos
# ruby exercises.rb -h

# --- BONUS: Add a --shout flag that upcases the greeting ---
