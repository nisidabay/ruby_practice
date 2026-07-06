#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You're validating 1000 emails. Every .match call allocates a MatchData object.
# Example: Bulk validation where you only need yes/no.
# Solution: .match? (Ruby 2.4+) returns boolean, allocates nothing, touches no globals.
# Visibility: Default to .match? for boolean checks; use .match only when you need captures.

emails = ['alice@example.com', 'bob@bad', 'carol@test.org', 'dave@']

# .match? — fast, no MatchData, no global $~ side effect
valid = emails.count { |e| e.match?(/\A[\w.]+@\w+\.\w+\z/) }
puts "Valid emails: #{valid}"   # => 2

# .match — returns MatchData (or nil), sets $~. Use when you need the capture groups.
log = '2026-06-25 ERROR: timeout from 10.0.0.1'
if (m = log.match(/(\d+\.\d+\.\d+\.\d+)/))
  puts "IP found: #{m[1]}"
end

# =~ — old-school, returns integer offset or nil. Sets $~ too.
puts 'Found vowels' if 'hello' =~ /[aeiou]/

# $~ global — avoid. It's set by =~ and .match, but also overwritten by ANY
# regex in the same thread. Race condition waiting to happen.
'first' =~ /(\w+)/
puts $1          # => "first"
'second' =~ /(\w+)/
puts $1          # => "second" (silently overwritten)

# This could also be done like this:
# Using .match just to check existence: email.match?(/.../) is ~30% faster and
# won't leak MatchData references. Save .match for when you actually need captures.

# Thinking in Ruby
#
# Ruby offers three match APIs with distinct trade-offs: .match? (boolean,
# zero allocation, no globals), .match (MatchData for captures), and =~
# (integer offset, sets $~). Choosing .match? by default and .match only
# when captures are needed reflects Ruby's pragmatic performance
# awareness — the fast path is also the simplest API.
