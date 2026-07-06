#!/usr/bin/env ruby
# frozen_string_literal: true

# 05_port_scanner_simple.rb — single-thread TCP port scanner
require "socket"

# Educational script: scans localhost ports and reports open/closed status.
# Demonstrates TCPSocket, Errno::ECONNREFUSED, and Error::EHOSTUNREACH.

def scan(host, port)
  TCPSocket.new(host, port).close
  puts " [+] Port #{port} is open"
rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
  puts " [-] Port #{port} is closed"
end

host = "127.0.0.1"
ports = (1..1024).to_a
puts "Scanning #{host} ports 1-1024..."
ports.each { |port| scan(host, port) }

# Thinking in Ruby
#
# A TCP port scanner in 20 lines — TCPSocket.new, rescue ECONNREFUSED,
# and iterate. Ruby's exception handling as control flow makes the
# scan logic crystal clear: try to connect, if it works it's open,
# if it fails it's closed. No async primitives, no state machines,
# just a rescue block and a range.
