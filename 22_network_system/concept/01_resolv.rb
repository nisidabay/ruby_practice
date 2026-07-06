#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Resolve domain names to IP addresses — DNS lookup from Ruby.
# Example: Find the IP address of ruby-lang.org.
#
# Solution: Resolv (stdlib) — DNS resolver, no external gems.
# Visibility: `require 'resolv'`. Works like `dig` or `nslookup` but in-process.

require 'resolv'

# Resolve a hostname to IP addresses
resolver = Resolv::DNS.new
addresses = resolver.getaddresses('ruby-lang.org')
puts 'ruby-lang.org addresses:'
addresses.each { |addr| puts "  #{addr}" }

# Usage: Resolve an IP back to hostname (reverse DNS)
names = resolver.getnames('8.8.8.8')
puts "\n8.8.8.8 names:"
names.each { |name| puts "  #{name}" }

# Usage: MX records (mail servers)
resolver.getresources('github.com', Resolv::DNS::Resource::IN::MX).each do |mx|
  puts "\nMX: #{mx.exchange} (priority #{mx.preference})"
end

# This could also be done like this:
# Shell command (slower, parse output):
#
#   `dig +short ruby-lang.org`.lines
#
# Resolv is faster (no subprocess) and gives structured results.
#
# Thinking in Ruby
#
# Resolv is a pure-Ruby DNS resolver — no libc dependency, no shelling out to
# dig or nslookup. This means DNS resolution behaves identically across all
# platforms Ruby runs on, regardless of the system resolver's quirks. Resolv
# gives you structured access to A, AAAA, MX, and other record types directly
# as Ruby objects, making network programming in Ruby more predictable and
# portable than shelling out to system tools.
