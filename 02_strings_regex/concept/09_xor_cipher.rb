#!/usr/bin/env ruby
# frozen_string_literal: true

# 09_xor_cipher.rb — XOR encryption/decryption from scratch
# Demonstrates: String#unpack('U*'), Array#zip, bitwise XOR (^), pack('U*'),
#               pattern matching with case/in (Ruby 3+), and padding algorithms.

# Core XOR cipher: zip two codepoint arrays, XOR each pair, repack.
def xor_bytes(data, password)
  data_bytes = data.unpack("U*")
  pass_bytes = pad_password(password, data_bytes.length)
  data_bytes.zip(pass_bytes).map { |a, b| a.to_i ^ b.to_i }.pack("U*")
end

# Pads the password to match the target length by rotating through it.
def pad_password(password, target_len)
  pass_bytes = password.unpack("U*")
  return pass_bytes if pass_bytes.length >= target_len

  pass_bytes.dup.fill(pass_bytes.length...target_len) do |i|
    pass_bytes[i % pass_bytes.length]
  end
end

# ── CLI via pattern matching (case/in) ──
case ARGV
in ["cipher", text, password, filename, *]
  result = xor_bytes(text, password)
  File.write(filename, result, encoding: "utf-8")
  puts "Encrypted → #{filename}"
in ["decipher", password, filename, *]
  data = File.read(filename, encoding: "utf-8")
  puts xor_bytes(data, password)
else
  puts "Usage:"
  puts "  ruby 09_xor_cipher.rb cipher <text> <password> <output_file>"
  puts "  ruby 09_xor_cipher.rb decipher <password> <input_file>"
  puts ""
  puts "Example:"
  puts "  ruby 09_xor_cipher.rb cipher 'hello world' secret /tmp/encrypted.txt"
  puts "  ruby 09_xor_cipher.rb decipher secret /tmp/encrypted.txt"
end

# Thinking in Ruby
#
# Ruby's pack/unpack with format strings gives raw byte-level access
# while keeping the code readable. The case/in pattern matching (Ruby 3+)
# makes multi-command CLI dispatch declarative — a syntax that eliminates
# entire classes of off-by-one ARGV errors. Zip + map + XOR in one
# expression shows how Ruby's Enumerable API composes elegantly.
