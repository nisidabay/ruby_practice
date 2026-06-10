#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — JSON, CSV, YAML practice

puts "=== 1. Parse this JSON into Ruby ==="
payload = '{"server":"nuc","cpu_count":4,"memory_gb":16,"labels":["amd64","linux"]}'
require "json"
data = JSON.parse(payload)
puts "Server: #{data["server"]}"
puts "CPUs: #{data["cpu_count"]}"
puts "Labels: #{data["labels"].join(" + ")}"

puts "\n=== 2. Write CSV from array of hashes ==="
begin
  require "csv"
rescue LoadError
  puts "⚠️  CSV gem not installed. Run: gem install csv"
  exit
end

servers = [
  {"host" => "web1", "ip" => "10.0.0.1", "role" => "frontend"},
  {"host" => "web2", "ip" => "10.0.0.2", "role" => "frontend"},
  {"host" => "db1",  "ip" => "10.0.1.1", "role" => "database"},
]

CSV.open("/tmp/servers.csv", "w") do |csv|
  csv << %w[host ip role]
  servers.each { |s| csv << [s["host"], s["ip"], s["role"]] }
end

CSV.foreach("/tmp/servers.csv", headers: true) do |row|
  puts "#{row["host"]} — #{row["ip"]} (#{row["role"]})"
end

puts "\n=== 3. Load YAML config with nested keys ==="
require "yaml"
conf = YAML.safe_load(<<~YAML)
  database:
    host: 10.0.1.10
    port: 5432
  redis:
    host: 10.0.1.20
    port: 6379
YAML

conf.each do |service, params|
  puts "#{service}: #{params["host"]}:#{params["port"]}"
end

# --- BONUS: Read a real JSON file from disk and count all keys in nested objects.
#   require "json"
#   blob = JSON.parse(File.read("some_file.json"))
#   def count_keys(obj)
#     # your loop here
#   end
#   puts count_keys(blob)

puts "\n=== 4. Logfmt Parser ==="
# Parse a logfmt string into a hash. Start with a simple approach.
line = 'status=200 method=GET path=/api/users'
result = {}
# --- your code here ---
# HINT: line.split.each { |pair| k, v = pair.split("="); result[k] = v }
puts result.inspect

puts "\n=== 5. MD5 Hash ==="
# Compute the MD5 hash of "hello" and compare it against a known value.
require "digest/md5"
known = "5d41402abc4b2a76b9719d911017c592"
# --- your code here ---
# HINT: Digest::MD5.hexdigest("hello")
# HINT: Check if result == known
