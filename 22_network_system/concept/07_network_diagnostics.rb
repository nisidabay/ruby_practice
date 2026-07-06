#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Build a network diagnostic tool that combines DNS, IP validation, and socket checks.
# Example: Check if a host is reachable, what IPs it resolves to, and if a port is open.
#
# Solution: Combine Resolv + IPAddr + Socket in one practical script.
# Visibility: All stdlib — no gems needed.

require 'resolv'
require 'ipaddr'
require 'socket'

host = ARGV[0] || 'ruby-lang.org'
port = (ARGV[1] || 443).to_i

puts "Checking #{host}:#{port}"
puts '=' * 40

# Step 1: DNS resolution
puts "\nDNS:"
resolver = Resolv::DNS.new
addresses = resolver.getaddresses(host)
if addresses.empty?
  puts "  Could not resolve #{host}"
  exit 1
end
addresses.each { |addr| puts "  #{addr}" }

# Step 2: IP validation
puts "\nIP validation:"
addresses.each do |addr|
  ip = IPAddr.new(addr.to_s)
  type = ip.ipv4? ? 'IPv4' : 'IPv6'
  private = ip.private? ? ' (private)' : ''
  puts "  #{addr} — #{type}#{private}"
end

# Step 3: TCP connectivity check
puts "\nTCP connectivity:"
addresses.each do |addr|
  begin
    socket = Socket.tcp(addr.to_s, port, connect_timeout: 3)
    puts "  #{addr}:#{port} — OPEN"
    socket.close
  rescue Errno::ECONNREFUSED
    puts "  #{addr}:#{port} — REFUSED"
  rescue Errno::ETIMEDOUT, Errno::EHOSTUNREACH
    puts "  #{addr}:#{port} — TIMEOUT/UNREACHABLE"
  end
end

# This could also be done like this:
# Shell commands (multiple subprocesses):
#
#   `dig +short #{host}`
#   `nc -zv -w3 #{host} #{port}`
#
# Ruby stdlib does it all in one process — faster, structured results.
#
# Thinking in Ruby
#
# This diagnostic script demonstrates a key Ruby philosophy: the standard library
# provides everything needed for real-world tasks. DNS resolution (Resolv), IP
# validation (IPAddr), and socket connectivity checks (Socket) all work together
# in a single process with zero external dependencies. Where sysadmins would
# traditionally chain dig, ping, and nc as shell commands, Ruby does it all
# in-process with structured, composable objects.
