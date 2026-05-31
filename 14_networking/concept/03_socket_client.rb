#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_socket_client.rb — raw TCP client with Socket
require "socket"

Socket.tcp("httpbin.org", 80) do |sock|
  sock.write "GET /get HTTP/1.1\r\nHost: httpbin.org\r\nConnection: close\r\n\r\n"
  sock.each_line { |line| puts line }
end
