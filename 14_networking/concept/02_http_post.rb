#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_http_post.rb — POST with Net::HTTP (form data and JSON body)
require "net/http"
require "uri"
require "json"

uri = URI("https://httpbin.org/post")

# JSON POST
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

body = {name: "Carlos", task: "learn networking"}.to_json
headers = {"Content-Type" => "application/json"}
response = http.post(uri.path, body, headers)

data = JSON.parse(response.body)
puts "Status: #{response.code}"
puts "Sent JSON: #{data["json"]}"

# Thinking in Ruby
#
# Net::HTTP.post sends JSON with custom headers in a few lines.
# The body is a Ruby hash converted to JSON, and the response is
# parsed back. This symmetry — hash to JSON to hash — is Ruby's
# data philosophy in action: the wire format matches your in-memory
# structures, and serialization is transparent.
