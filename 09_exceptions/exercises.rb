#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Error handling practice

puts "=== Exercise 1: Safe read ==="
def safe_read(path)
  # --- your code here ---
  # HINT: File.read(path) rescue nil
end
puts safe_read("nonexistent.txt").inspect

puts "
=== Exercise 2: Ensure close ==="
def with_file(path)
  f = File.open(path, "r")
  # HINT: begin...ensure f.close
rescue StandardError => e
  puts "Error: #{e.message}"
end

puts "
=== Exercise 3: Retry ==="
def retry_read(path, max_attempts: 3)
  attempts = 0
  begin
    File.read(path)
  rescue Errno::ENOENT
    attempts += 1
    if attempts < max_attempts
      sleep 0.1
      retry
    else
      nil
    end
  end
end
