#!/usr/bin/env ruby
# frozen_string_literal: true

# 01_http_get.rb — simple GET request with Net::HTTP
require "net/http"
require "uri"
require "json"

uri = URI("https://httpbin.org/get?name=Carlos")
response = Net::HTTP.get_response(uri)

puts "Status: #{response.code} #{response.message}"
puts "Body length: #{response.body.length} bytes"

data = JSON.parse(response.body)
puts "URL: #{data["url"]}"
puts "Args: #{data["args"]}"

# Thinking in Ruby
#
# Net::HTTP.get_response is one method call for a complete HTTP GET.
# Ruby parses the response, handles redirects, and gives you access
# to status code, headers, and body. Combined with JSON.parse, a
# REST API call is 3 lines: build URI, fetch, parse. No HTTP client
# gem required — Ruby ships with everything you need.
