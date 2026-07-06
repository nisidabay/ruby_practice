#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_csv_read_write.rb — read and write CSV with the csv library
begin
  require "csv"
rescue LoadError
  puts "⚠️  CSV gem not installed. Run: gem install csv"
  exit 1
end

# Write
CSV.open("/tmp/ruby_users.csv", "w") do |csv|
  csv << %w[name role active]
  csv << ["Carlos", "admin", "true"]
  csv << ["Ada", "developer", "true"]
  csv << ["Grace", "reviewer", "false"]
end

# Read with headers
CSV.foreach("/tmp/ruby_users.csv", headers: true) do |row|
  puts "#{row["name"]} — #{row["role"]} (#{row["active"]})"
end

# Thinking in Ruby
#
# Ruby's CSV library turns tabular data into familiar row objects.
# CSV.open writes arrays, CSV.foreach with headers: true gives you
# hash-like access by column name. The ergonomics mirror Ruby's
# philosophy: data formats should feel like Ruby data structures,
# not require a separate data-processing language.
