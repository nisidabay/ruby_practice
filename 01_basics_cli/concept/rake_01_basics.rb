#!/usr/bin/env ruby
# frozen_string_literal: true

# rake_01_basics.rb — define and depend on tasks
# Save this as Rakefile, then run: rake download  or  rake process
# (Rakefile must be named exactly "Rakefile" — no .rb)

# task :download do
#   puts "Downloading data..."
#   sleep 1
#   File.write("/tmp/data.txt", "raw,data,here")
# end
#
# task :process => :download do   # depends on :download
#   puts "Processing..."
#   data = File.read("/tmp/data.txt")
#   puts "Got: #{data}"
# end
#
# task :clean do
#   File.delete("/tmp/data.txt") rescue nil
#   puts "Cleaned"
# end

puts "This file is a template — save as Rakefile and run: rake process"
puts "See project/ directory for a working Rakefile"
