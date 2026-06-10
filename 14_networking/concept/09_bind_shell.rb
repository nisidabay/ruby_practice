#!/usr/bin/env ruby
# frozen_string_literal: true

# 09_bind_shell.rb — TCP bind shell with password authentication
require "socket"
require "open3"

# EDUCATIONAL SCRIPT — localhost only, for learning Ruby patterns.
# Demonstrates Socket.tcp_server_loop, password auth,
# Open3.popen2e for command execution, and Dir.chdir.

if ARGV.empty?
  puts "Usage: ruby 09_bind_shell.rb <port> [password]"
  exit 1
end

PORT = ARGV[0].to_i
PASS = ARGV[1] || "knock-knock"

trap("SIGINT") do
  puts "\nClosing server..."
  exit 0
end

puts "Bind shell listening on port #{PORT}..."
puts "Password: #{PASS}"

Socket.tcp_server_loop(PORT) do |socket, client_addrinfo|
  client_info = client_addrinfo.ip_address
  puts "Connection from #{client_info}"

  socket.puts "Password:"
  auth = socket.gets&.chomp

  if auth != PASS
    socket.puts "Access denied."
    socket.close
    puts "Auth failed from #{client_info}"
    next
  end

  socket.puts "Authenticated. Type EXIT/QUIT to leave, KILLZ/CLOSE to terminate."

  work_dir = Dir.pwd
  loop do
    socket.print "#{work_dir}> "
    cmd = socket.gets&.chomp
    break if cmd.nil? || %w[exit quit].include?(cmd.downcase)
    exit 0 if %w[killz close].include?(cmd.downcase)

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
  puts "Client #{client_info} disconnected."
end
