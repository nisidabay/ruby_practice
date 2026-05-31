#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Time arithmetic practice

puts "=== Exercise 1: File age ===\n\n"
path = __FILE__
age = Time.now - File.mtime(path)
puts "#{path} is #{age.to_i} seconds old"
puts "#{(age / 86400).round(2)} days old"
puts "#{(age / 3600).round(1)} hours old"

puts "\n=== Exercise 2: Future date ===\n\n"
cutoff = Time.now + (30 * 86400)
puts "30 days from now: #{cutoff}"
puts "  Day of week: #{cutoff.strftime('%A')}"
puts "  Formatted:   #{cutoff.strftime('%Y-%m-%d %H:%M')}"

puts "\n=== Exercise 3: Duration formatter ===\n\n"
def format_duration(seconds)
  h = seconds / 3600
  m = (seconds % 3600) / 60
  s = seconds % 60
  "#{h}h #{m}m #{s}s"
end
puts format_duration(3661)   # => 1h 1m 1s
puts format_duration(90)     # => 0h 1m 30s
puts format_duration(7200)   # => 2h 0m 0s

puts "\n=== Exercise 4: Days between dates ===\n\n"
christmas = Time.new(Time.now.year, 12, 25)
days_left = ((christmas - Time.now) / 86400).ceil
puts "#{days_left} days until Christmas #{Time.now.year}"

birthday = Time.new(2026, 11, 15)
bdays_left = ((birthday - Time.now) / 86400).ceil
puts "#{bdays_left} days until Nov 15"

puts "\n=== Exercise 5: Epoch round-trip ===\n\n"
now = Time.now
ts = now.to_i
reconstructed = Time.at(ts)
puts "Original:        #{now}"
puts "Epoch timestamp: #{ts}"
puts "Reconstructed:   #{reconstructed}"
puts "Match: #{now.to_i == reconstructed.to_i}"

# --- BONUS: Write a `business_days_between` method that counts
# weekdays (Mon-Fri) between two dates. Start simple — skip holidays.
