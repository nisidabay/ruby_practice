#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Work with IP addresses — validate, compare, check subnets.
# Example: Is 192.168.1.100 in the 192.168.1.0/24 subnet?
#
# Solution: IPAddr (stdlib) — IP address and subnet manipulation.
# Visibility: `require 'ipaddr'`. Supports IPv4, IPv6, CIDR notation.

require 'ipaddr'

# Create IP addresses
ip = IPAddr.new('192.168.1.100')
puts "IP: #{ip}"

# Check if an IP is in a subnet
subnet = IPAddr.new('192.168.1.0/24')
puts "In subnet? #{subnet.include?(ip)}"  # => true

# Usage: Iterate a subnet
puts "\nFirst 5 IPs in 10.0.0.0/28:"
IPAddr.new('10.0.0.0/28').to_range.take(5).each { |addr| puts "  #{addr}" }

# Usage: IPv6 support
ipv6 = IPAddr.new('2001:db8::1')
puts "\nIPv6: #{ipv6}"
puts "Loopback? #{ipv6.loopback?}"

# Usage: Convert between formats
ip4 = IPAddr.new('192.168.1.1')
puts "\nInteger: #{ip4.to_i}"       # => 3232235777
puts "Hex: #{ip4.to_i.to_s(16)}"    # => c0a80101

# This could also be done like this:
# String manipulation (error-prone):
#
#   parts = '192.168.1.100'.split('.').map(&:to_i)
#   subnet_parts = '192.168.1.0'.split('.').map(&:to_i)
#   in_subnet = parts[0..2] == subnet_parts[0..2]
#
# IPAddr handles edge cases (IPv6, CIDR, netmasks) correctly.
#
# Thinking in Ruby
#
# IPAddr is a domain-specific value class that makes IP address math feel natural
# in Ruby. Subnet checks become simple `include?` calls, iteration over a range
# uses standard Enumerable methods, and IPv6 is handled transparently alongside
# IPv4. This reflects a Ruby design principle: when a domain has native concepts
# (IP addresses, subnets), model them as objects with meaningful methods rather
# than leaving developers to manipulate strings and integers.
