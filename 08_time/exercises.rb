#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Time arithmetic practice

puts "=== Exercise 1: File age ==="
path = "exercises.rb"
# HINT: age = Time.now - File.mtime(path)
# puts "#{age / 86400} days old"

puts "
=== Exercise 2: Future date ==="
cutoff = Time.now + (30 * 86400)
puts "30 days from now: #{cutoff}"

puts "
=== Exercise 3: Duration format ==="
def format_duration(seconds)
  # --- your code here ---
  # HINT: hours = seconds / 3600; minutes = (seconds % 3600) / 60
  "#{seconds}s"
end
puts format_duration(3661)
