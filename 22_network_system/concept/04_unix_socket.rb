#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Communicate between processes on the same machine — faster than TCP.
# Example: A worker process sends results to a collector process.
#
# Solution: UNIXSocket (stdlib) — local IPC via file-system socket.
# Visibility: Part of Socket. Only works on the same machine. No network overhead.

require 'socket'
require 'tmpdir'

Dir.mktmpdir('unix_demo_') do |dir|
  socket_path = File.join(dir, 'demo.sock')

  # Server (in a thread)
  server = Thread.new do
    UNIXServer.open(socket_path) do |server_socket|
      client = server_socket.accept
      msg = client.gets
      puts "[Server] Received: #{msg.chomp}"
      client.puts 'ACK'
      client.close
    end
  end

  sleep 0.1  # let server start

  # Client
  UNIXSocket.open(socket_path) do |client_socket|
    client_socket.puts 'Hello via Unix socket!'
    response = client_socket.gets
    puts "[Client] Response: #{response.chomp}"
  end

  server.join
end

# Usage: Socket pair — two connected sockets, no filesystem path
parent_sock, child_sock = UNIXSocket.pair
child_sock.puts 'Direct message'
puts "Parent received: #{parent_sock.gets.chomp}"

# This could also be done like this:
# TCPSocket on localhost — works but has TCP overhead:
#
#   TCPSocket.new('127.0.0.1', 9999)
#
# UNIXSocket is faster (no TCP stack, no network) and uses filesystem
# permissions for access control.
