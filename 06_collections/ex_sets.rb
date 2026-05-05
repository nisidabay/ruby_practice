#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

# ex_sets.rb — parse customers.txt, return Set of unique phone numbers
# Format: name,phone per line

def generate_unique_phone_numbers(filename)
  phones = Set.new
  return phones unless File.exist?(filename)

  File.readlines(filename).each do |line|
    parts = line.chomp.split(',')
    phones.add(parts[1].strip) if parts.length > 1
  end
  phones
end

p generate_unique_phone_numbers('customers.txt')
