#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Exception handling practice
#
# Uncomment and fix each challenge.

# --- 1. Raise with a message ---
def check_age(age)
  # raise an ArgumentError if age is negative
  # your code here
end

# check_age(-5)  # should raise ArgumentError

# --- 2. Custom exception ---
# Define a ValidationError < StandardError that stores the field name
# and prints "Invalid field: <field>"
# your code here

# --- 3. ensure block ---
# Write a method that opens a file, reads it, and ensures the file
# is closed even if reading raises.
# your code here

# --- 4. Rescue hierarchy ---
# Write a begin/rescue that catches Errno::ENOENT first,
# then PermissionError (custom), then StandardError.
# your code here

# --- BONUS: retry with counter ---
# Try to read a file, if it fails, retry up to 3 times with a counter.
# your code here
