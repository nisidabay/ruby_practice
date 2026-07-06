#!/usr/bin/env ruby
# frozen_string_literal: true

# 04_timeout_ssl.rb — timeouts and SSL with Net::HTTP
require "net/http"
require "uri"

uri = URI("https://httpbin.org/delay/3")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.open_timeout = 2     # connection timeout
http.read_timeout = 2     # response timeout

begin
  response = http.get(uri.path)
  puts "Status: #{response.code}"
rescue Net::OpenTimeout
  puts "Connection timed out"
rescue Net::ReadTimeout
  puts "Response took too long"
end

puts "\nSSL check: #{uri.scheme} uses encryption" if uri.scheme == "https"

# Thinking in Ruby
#
# Net::HTTP with explicit open_timeout and read_timeout gives you
# fine-grained control over network resilience. SSL is a single flag
# (use_ssl = true), and timeout exceptions (Net::OpenTimeout,
# Net::ReadTimeout) are first-class Ruby exceptions you rescue
# normally. Secure, timed HTTP in 24 lines — all stdlib.
