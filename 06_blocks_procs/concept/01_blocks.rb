#!/usr/bin/env ruby
# frozen_string_literal: true

# 01_blocks.rb — blocks eliminate setup/teardown repetition

# WITHOUT blocks — copy-paste the ceremony every time:
#
#   puts "Connecting to DB..."
#   rows = query("SELECT * FROM users")
#   puts "Closing DB connection..."
#
#   puts "Connecting to DB..."
#   count = query("SELECT COUNT(*) FROM orders")
#   puts "Closing DB connection..."
#
# WITH blocks — the ceremony lives ONCE:

def query(sql)
  puts "  Running: #{sql}"
  sql.include?("COUNT") ? 42 : ["carlos", "ana"]
end

def with_db
  puts "Connecting to DB..."
  result = yield
  puts "Closing DB connection..."
  result
end

with_db { query("SELECT * FROM users") }
with_db { query("SELECT COUNT(*) FROM orders") }
