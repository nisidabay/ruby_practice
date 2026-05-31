#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_backticks_vs_system.rb — backticks (capture output) vs system() (check exit status only)
output = `ls /tmp | head -3`
puts "Backticks captures output:"
puts output

puts "---"

ok = system("ls", "/tmp", out: File::NULL, err: File::NULL)
puts "system() returns boolean: #{ok}"
