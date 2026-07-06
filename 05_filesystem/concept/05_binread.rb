#!/usr/bin/env ruby
# frozen_string_literal: true

# 05_binread.rb — binary-safe reading that preserves every byte
#
# File.read uses your default encoding (UTF-8). Binary files contain
# bytes that are NOT valid UTF-8 — encoding errors or silent corruption.
#
# WITHOUT binread:
#
#   data = File.read("photo.png")       # may mangle bytes
#   data = File.read("photo.png", mode: "rb")  # works but verbose
#
# WITH binread — guaranteed raw bytes, no encoding interference:

# Simulating a binary file header (PNG magic: \x89PNG\r\n\x1a\n)
require 'tempfile'

Tempfile.create(['thumbnail', '.png']) do |tmp|
  # Manually write PNG magic bytes + fake IHDR chunk
  tmp.binmode
  tmp.write("\x89PNG\r\n\x1a\n")
  tmp.write('FAKE_IMAGE_DATA')
  tmp.rewind

  # binread — raw bytes, no encoding applied
  raw = File.binread(tmp.path)
  puts "binread: #{raw.bytesize} bytes"
  puts "         #{raw.bytes.map { |b| format('%02X', b) }.first(8).join(' ')} ..."

  # First 4 magic bytes
  magic = File.binread(tmp.path, 4)
  expected_png = [0x89, 0x50, 0x4E, 0x47] # \x89 P N G
  puts "Magic:   #{magic.inspect} (#{magic.bytes})"
  puts "Is PNG?  #{magic.bytes == expected_png}" # => true

  # File.read with UTF-8 works here but isn't guaranteed for real binaries
  text = File.read(tmp.path)
  puts "read:    #{text.bytesize} bytes (UTF-8 — identical here, but NOT safe for arbitrary binaries)"
end

# Use binread for: images, audio, video, encrypted data, protocol buffers,
# or ANY file where you need the exact bytes on disk — not Ruby's
# interpretation of them.

# Thinking in Ruby
#
# File.binread demonstrates Ruby's respect for the programmer's intent.
# File.read applies encoding rules (UTF-8 by default) because that's what
# you usually want for text. binread skips ALL encoding — you get raw bytes.
# Two methods, two clear purposes, no mode flags cluttering the call site.
