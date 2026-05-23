#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Regex: match, scan, substitute, capture

text = "My email is carlos@example.com and my phone is 555-1234"

# --- Find all words ---
words = text.scan(/\w+/)
puts words.inspect  # => ["My", "email", "is", "carlos", ...]

# --- Extract the email ---
email_match = text.match(/(\S+@\S+)/)
puts "Email: #{email_match[1]}"  # => carlos@example.com

# --- Replace phone format: 555-1234 -> (555) 1234 ---
fixed = text.gsub(/(\d{3})-(\d{4})/, '(\1) \2')
puts fixed  # => My email is carlos@example.com and my phone is (555) 1234

# --- Validate: is this a valid-looking email? ---
def valid_email?(str)
  !!(str =~ /\A[\w.+-]+@[\w-]+\.[a-z]{2,}\z/i)
end
puts valid_email?("carlos@example.com")  # => true
puts valid_email?("not-an-email")        # => false
