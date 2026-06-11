#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Logging & Security practice

require 'logger'
require 'securerandom'
require 'English'
require 'shellwords'
require 'zlib'
require 'erb'
require 'etc'

puts '=== Exercise 1: Logger ==='
logger = Logger.new($stdout)
logger.formatter = proc { |sev, time, _prog, msg| "[#{sev}] #{msg}\n" }
logger.info('Logging works!')

puts "\n=== Exercise 2: SecureRandom ==="
puts "Token: #{SecureRandom.urlsafe_base64(16)}"
puts "UUID: #{SecureRandom.uuid}"

puts "\n=== Exercise 3: English ==="
puts "Program: #{$PROGRAM_NAME}"
puts "PID: #{$PROCESS_ID}"

puts "\n=== Exercise 4: Shellwords ==="
cmd = Shellwords.shelljoin(['ls', '-la', 'My Documents'])
puts "Safe command: #{cmd}"

puts "\n=== Exercise 5: Zlib ==="
data = 'Hello! ' * 20
compressed = Zlib.gzip(data)
puts "Compressed: #{data.bytesize} → #{compressed.bytesize} bytes"

puts "\n=== Exercise 6: ERB ==="
name = 'Rubyist'
template = ERB.new('Hello, <%= name %>!')
puts template.result(binding)
