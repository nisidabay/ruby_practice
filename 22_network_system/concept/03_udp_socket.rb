#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Communicate over UDP — lightweight, connectionless messaging.
# Example: Send a log message to a local syslog server.
#
# Solution: UDPSocket (stdlib) — send and receive datagrams.
# Visibility: Part of Socket. No connection setup, just fire and forget.

require 'socket'

# UDP server (in a thread — for demo)
server = Thread.new do
  socket = UDPSocket.new
  socket.bind('127.0.0.1', 9999)
  msg, addr = socket.recvfrom(1024)
  puts "[Server] Received: #{msg} from #{addr[2]}:#{addr[1]}"
  socket.close
end

sleep 0.1  # let server start

# UDP client — send a message
client = UDPSocket.new
client.send('Hello via UDP!', 0, '127.0.0.1', 9999)
puts '[Client] Sent message'
client.close

server.join

# Usage: Broadcast (send to all on the subnet)
# socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
# socket.send('DISCOVER', 0, '255.255.255.255', 9999)

# This could also be done like this:
# TCP — connection-oriented, reliable, ordered:
#
#   TCPSocket.new('127.0.0.1', 9999)  # connect first
#
# UDP is for when you don't need reliability (DNS, syslog, gaming,
# discovery protocols). TCP is for when you do (HTTP, SSH, databases).
