#!/usr/bin/env ruby
# frozen_string_literal: true

# 10_exercises.rb — Time problems to solve by editing this file

require 'time'
require 'date'

# 1. How many Fridays until the end of this year?

today = Date.today
year_end = Date.new(2026, 12, 31)
fridays = (today..year_end).count(&:friday?)
puts "Fridays left: #{fridays}"

# 2. What time is 10,000 hours from now?

now = Time.now
future_time = now + (10_000 * 3600)
puts "10k hours from now: #{future_time}"

# 3. Given a UTC timestamp from a server, show it in Tokyo and New York.

require 'time'

server_time = Time.parse('2026-05-08 10:30:00 UTC')
tokyo_time = server_time.getlocal('+09:00')
nyc_time = server_time.getlocal('-05:00')

puts "Server (UTC): #{server_time}"
puts "Tokyo:        #{tokyo_time}"
puts "New York:     #{nyc_time}"

# 4. Your flight lands in Madrid at 06:30 local Nov 15, 2026 (+01:00).

landing = Time.new(2026, 11, 15, 6, 30, 0, '+01:00')
flight_duration = 13 * 3600
estimated_departure = landing - flight_duration
departure = estimated_departure.getlocal('+09:00')
puts "Depart from Tokyo at: #{departure}"

# 5. How old are you in days? Uncomment and fill in your birthdate.
# birth = Date.new(1990, 1, 1)  # <-- change me

# days_old = (Date.today - birth).to_i
# puts "You are #{days_old} days old"
