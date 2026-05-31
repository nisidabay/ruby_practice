#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — HTTP and sockets practice

puts "=== 1. Check your internet ==="
require "net/http"
require "uri"
require "json"

uri = URI("https://httpbin.org/ip")
response = Net::HTTP.get_response(uri)
puts "Status: #{response.code}"
puts "Your IP: #{JSON.parse(response.body)["origin"]}"

puts "\n=== 2. Download size without body ==="
begin
  uri = URI("https://httpbin.org/image/jpeg")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  head = http.request_head(uri.path)
  puts "Content-Type: #{head["content-type"]}"
  puts "Size: #{head["content-length"]} bytes"
rescue => e
  puts "Error: #{e.message}"
end

puts "\n=== 3. Simple TCP echo server ==="
require "socket"

server = TCPServer.new("127.0.0.1", 10_000)
Thread.new do
  client = server.accept
  msg = client.gets
  client.puts "ECHO: #{msg}"
  client.close
end

sleep 1
sock = TCPSocket.new("127.0.0.1", 10_000)
sock.puts "Hello from Ruby!"
response = sock.gets
sock.close
server.close

puts response

# --- BONUS: Write a tiny web server that listens on port 8080
# and responds "Hello, browser!" to any HTTP request.
#   require "socket"
#   server = TCPServer.new("127.0.0.1", 8080)
#   loop do
#     client = server.accept
#     client.puts "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, browser!"
#     client.close
#   end
