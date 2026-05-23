#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_gets_vs_readline.rb — safe reading: nil vs EOFError
#
# f.gets and f.readline both read one line. The difference is what happens
# at the end of the file:
#
#   gets     → returns nil       (safe — loop stops silently)
#   readline → raises EOFError   (crashes unless you rescue)
#
# If you use readline without a rescue, your program dies at EOF:

require 'tempfile'

Tempfile.create(['inventory', '.csv']) do |tmp|
  tmp.write("widget,5.99\nhammer,12.50\nnails,3.25\n")
  tmp.rewind

  # gets — safe loop, stops when nil
  puts ' gets (safe loop) '
  File.open(tmp.path) do |f|
    while (line = f.gets)
      puts "  #{line.chomp}"
    end
  end

  # readline — blows up without rescue
  puts "\n readline (explodes) "
  File.open(tmp.path) do |f|
    puts "  #{f.readline.chomp}"
    puts "  #{f.readline.chomp}"
    puts "  #{f.readline.chomp}"
    puts "  #{f.readline.chomp}" # EOFError — file only has 3 lines
  rescue EOFError
    puts "  (EOFError caught — program would've crashed without this rescue)"
  end
end

# Rule of thumb: gets for loops, readline when you know exactly how many
# lines to expect and you WANT it to blow up on bad input.
