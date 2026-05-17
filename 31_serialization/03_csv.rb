#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_csv.rb — CSV: tabular data, spreadsheets, exports
#
# Ruby ≥ 3.4: csv was removed from default gems. Install it:
#   gem install csv
# This file demonstrates the pattern — it's the standard library approach.
#
# WITHOUT CSV — split on commas and pray:
#
#   row = '"Smith, John",42,Engineer'.split(",")
#   # => ['"Smith', ' John"', '42', 'Engineer'] — broken on the quoted comma
#
# WITH CSV — handles quoting, escaping, headers, all edge cases:

begin
  require "csv"

  # Parse: CSV string → array of arrays
  data = <<~CSV
    name,role,team
    Alice Chen,backend,gold
    Bob Martinez,frontend,silver
    Carol Nguyen,devops,gold
  CSV

  csv = CSV.parse(data, headers: true)
  puts "Headers: #{csv.headers.join(', ')}"
  puts "Team gold members:"
  csv.each do |row|
    puts "  #{row['name']} (#{row['role']})" if row["team"] == "gold"
  end
  # => Alice Chen (backend)
  #    Carol Nguyen (devops)

  # Generate: array of arrays → CSV string
  require "tempfile"
  Tempfile.create(["roster", ".csv"]) do |tmp|
    rows = [
      ["name", "email", "active"],
      ["Diana Park", "diana@example.com", "true"],
      ["Erik Johansson", "erik@example.com", "false"]
    ]

    CSV.open(tmp.path, "w") do |csv_file|
      rows.each { |row| csv_file << row }
    end

    puts "\nGenerated CSV:"
    puts File.read(tmp.path)
  end

  # CSV.foreach — stream large files line by line (memory-efficient)
  # CSV.parse   — load everything into memory
  # CSV.open with block — auto-closes the file
rescue LoadError
  puts "⚠️  CSV gem not installed."
  puts "   Run: gem install csv"
  puts "   (CSV was removed from Ruby 3.4 default gems)"
end
