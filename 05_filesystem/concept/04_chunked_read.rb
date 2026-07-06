#!/usr/bin/env ruby
# frozen_string_literal: true

# 04_chunked_read.rb — streaming chunks via read(N)
#
# A file has an invisible cursor. Every f.read(N) advances it by N bytes.
# The next f.read picks up right where the last one left off.
#
# WITHOUT sequential read — you'd need to track offsets manually:
#
#   f.seek(0)     # go back to start
#   f.seek(30)    # jump past the header
#
# WITH chunked read — the position handles itself:

require 'tempfile'

Tempfile.create(['network', '.pcap']) do |tmp|
  # Pretend this is a binary protocol: 30-byte header + payload
  tmp.write("PKTHEADER:v2\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00[payload: 192.168.1.1 → 10.0.0.5]")
  tmp.rewind

  File.open(tmp.path) do |f|
    header = f.read(30)  # reads first 30 bytes, position = 30
    body   = f.read      # reads from position 30 to EOF

    puts "Header (#{header.bytesize} bytes): #{header.inspect}"
    puts "Body   (#{body.bytesize} bytes):   #{body.inspect}"
  end
end

# This is how you process files too big for memory:
#
#   File.open("giant.csv") do |f|
#     while (chunk = f.read(8192))  # 8KB at a time
#       process(chunk)
#     end
#   end
#
# f.read returns nil when position hits EOF, so the loop stops.

# Thinking in Ruby
#
# Ruby's read(N) makes file cursors invisible — you don't track offsets,
# you just read chunks and the position advances automatically. The idiom
# `while (chunk = f.read(8192))` is a hallmark of Ruby IO: readable,
# self-terminating, and memory-safe. No manual seek math needed.
