#!/usr/bin/env ruby
# frozen_string_literal: true

# 06_reverse_shell_integration.rb — Open3 + socket process piping
require "socket"
require "open3"

# Educational script: demonstrates Open3.popen2e with socket I/O.
# This is the core pattern used in reverse shells — executing commands
# and piping their output through a TCP connection.
# Safe demo: runs an echo server locally.

server = TCPServer.new("127.0.0.1", 9999)
puts "Echo server on port 9999. Connect with: nc 127.0.0.1 9999"

Thread.new do
  loop do
    client = server.accept
    puts "Client connected."

    # Capture command output and send it back through the socket
    output, _error, status = Open3.capture3("uname -a")
    client.puts "Server info: #{output.chomp}"

    # Interactive loop: read commands from client, execute via Open3
    loop do
      client.print "cmd> "
      cmd = client.gets&.chomp
      break if cmd.nil? || %w[exit quit].include?(cmd.downcase)

      if cmd.match?(/cd (.+)/i)
        Dir.chdir(::Regexp.last_match(1))
        client.puts "Changed to #{Dir.pwd}"
        next
      end

      # popen2e: opens a process with combined stdout+stderr
      Open3.popen2e(cmd) do |_stdin, stdothers|
        IO.copy_stream(stdothers, client)
      end
    rescue StandardError => e
      client.puts "Error: #{e.message}"
    end

    client.close
    puts "Client disconnected."
  end
end

# Keep main thread alive, handle Ctrl+C cleanly
trap("SIGINT") do
  puts "\nShutting down..."
  server.close
  exit 0
end

sleep

# Thinking in Ruby
#
# Open3.popen2e combined with TCPServer creates a remote command
# executor. Thread.new handles the client loop concurrently while
# the main thread manages signals. Ruby's process-control and
# networking libraries are designed to work together — capture3
# for one-shot commands, popen2e for interactive execution,
# all piped through a single TCP socket.
