#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Dir and File operations

# --- List all .rb files in the current directory ---
# rb_files = Dir.glob("*.rb")
# puts "Found #{rb_files.size} Ruby files:"
# rb_files.each { |f| puts "  #{f}" }

# --- Create a directory, write a file inside it, then clean up ---
dirname = "tmp_practice_#{Time.now.to_i}"
Dir.mkdir(dirname)
File.write("#{dirname}/hello.txt", "Ruby filesystem practice\n")
puts File.read("#{dirname}/hello.txt")
File.delete("#{dirname}/hello.txt")
Dir.rmdir(dirname)
puts "Cleaned up #{dirname}"

# --- Walk a directory tree: print all filenames under ~/r_ruby_practice/02_strings_and_text ---
# Dir.glob("#{Dir.home}/r_ruby_practice/02_strings_and_text/**/*.rb") do |path|
#   puts File.basename(path)
# end
