#!/usr/bin/env ruby
# frozen_string_literal: true

# 11_cgi_urlencode.rb — URL encoding/decoding with CGI
# Build search URLs, parse query strings, handle special characters.
require "cgi"

# ── CGI.escape: encode for URLs ──────────────────────────────────────

query = "hello world & ruby!"
encoded = CGI.escape(query)
puts "Raw:    #{query}"
puts "Encoded: #{encoded}"
# => hello+world+%26+ruby%21

# ── CGI.unescape: decode back ────────────────────────────────────────

decoded = CGI.unescape(encoded)
puts "Decoded: #{decoded}"
puts "Roundtrip OK: #{query == decoded}"

# ── Building a search URL ────────────────────────────────────────────

engines = {
  "brave"  => "https://search.brave.com/search?q=",
  "google" => "https://www.google.com/search?q=",
  "duck"   => "https://duckduckgo.com/?q="
}

term = "nim language tutorial"
engine = "google"
url = "#{engines[engine]}#{CGI.escape(term)}"
puts "\nSearch URL: #{url}"

# ── CGI.parse: decode a full query string ────────────────────────────

query_string = "name=Carlos&lang=ruby&lang=nim&page=1"
parsed = CGI.parse(query_string)
puts "\nParsed query string:"
parsed.each { |k, v| puts "  #{k} => #{v.inspect}" }
# name => ["Carlos"], lang => ["ruby", "nim"], page => ["1"]
