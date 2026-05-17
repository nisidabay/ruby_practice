#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Process management practice

# --- 1. system vs backticks ---
# Use system to echo "hello" and backticks to capture "hostname"
# your code here

# --- 2. spawn and wait ---
# Spawn a sleep(2), print the PID, and wait for it to finish
# your code here

# --- 3. popen grep ---
# Write a temp file with 3 lines, use IO.popen with grep to filter one
# your code here

# --- 4. Open3 capture3 ---
# Run "ls /tmp /nonexistent_dir", capture stdout, stderr, and exit status
# your code here

# --- BONUS: fork pipeline ---
# fork, have the child write to a pipe, parent reads from it
