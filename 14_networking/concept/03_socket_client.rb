#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_socket_client.rb — raw TCP client with Socket
require "socket"

Socket.tcp("httpbin.org", 80) do |sock|
  sock.write "GET /get HTTP/1.1\r\nHost: httpbin.org\r\nConnection: close\r\n\r\n"
  sock.each_line { |line| puts line }
end

# Thinking in Ruby
#
# Socket.tcp with a block manages the connection lifecycle automatically
# — no explicit close needed. Writing raw HTTP and reading line by line
# shows Ruby at the socket level: you craft the request yourself and
# iterate the response. The block form (closed on exit) is Ruby's
# resource-management pattern, inherited from File.open.
