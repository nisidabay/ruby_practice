#!/usr/bin/env ruby
# frozen_string_literal: true

# 05_port_scanner_threaded.rb — multithreaded TCP port scanner
require "socket"
require "timeout"

# Educational script: scans ports using threads for concurrency.
# Demonstrates Queue (thread-safe work distribution), Mutex (output sync),
# Timeout (prevent hangs), and IPSocket (hostname resolution).

class PortScanner
  attr_accessor :host, :ports

  def initialize(host)
    @host = IPSocket.getaddress(host)
    @ports = (1..1024).to_a.freeze
  end

  # Attempt a single port connection with a timeout.
  def port_open(port, tout = 1)
    Timeout.timeout(tout) do
      TCPSocket.new(@host, port).close
      "OPEN"
    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
      "CLOSED"
    end
  rescue Timeout::Error
    "CLOSED"
  end

  # Distribute ports across threads using Queue + Mutex.
  def run
    qpool = Queue.new
    mpool = Mutex.new
    @ports.each { |port| qpool << port }

    @ports.size.times.map do
      Thread.new do
        while !qpool.empty?
          port = qpool.pop(true) rescue nil
          next unless port

          status = port_open(port)
          mpool.synchronize do
            puts "PORT %-7s %-5s" % [port, status]
          end
        end
      end
    end.each(&:join)
  end
end

host = ARGV.shift || "127.0.0.1"
puts "Scanning #{host} (ports 1-1024)..."
PortScanner.new(host).run
puts "Done."

# Thinking in Ruby
#
# port_scanner_threaded demonstrates real-world threaded Ruby in action.
# It distributes port scanning across threads using Queue (work distribution),
# Mutex (output synchronization), and Timeout (prevent hangs from unresponsive
# ports). The pattern — fill a queue with work, spawn N consumers, have them
# pop-and-process — is the standard Ruby approach to parallel I/O-bound tasks.
# TCPSocket with Timeout is the go-to for any network probing in Ruby.
