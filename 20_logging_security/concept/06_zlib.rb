#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You need to compress or decompress data — gzip logs, unzip archives.
# Example: Rotate a log file: compress yesterday's log, start a fresh one.
#
# Solution: Zlib (stdlib) — gzip compression and decompression.
# Visibility: `require 'zlib'`. Works on strings and streams.

require 'zlib'

# Compress a string
original = 'Hello Ruby! ' * 100  # 1200 bytes
compressed = Zlib.gzip(original)
puts "Original: #{original.bytesize} bytes"
puts "Compressed: #{compressed.bytesize} bytes"
puts "Ratio: #{(compressed.bytesize.to_f / original.bytesize * 100).round(1)}%"

# Decompress
restored = Zlib.gunzip(compressed)
puts "Restored matches? #{restored == original}"

# Usage: Compress a file
# Zlib::GzipWriter.open('data.gz') { |gz| gz.write(File.read('data.txt')) }

# Usage: Decompress a file
# content = Zlib::GzipReader.open('data.gz') { |gz| gz.read }

# Usage: Deflate/Inflate (raw, no gzip header)
deflated = Zlib.deflate(original)
inflated = Zlib.inflate(deflated)
puts "Deflate/Inflate works? #{inflated == original}"

# This could also be done like this:
# System gzip command (slower, external dependency):
#
#   system('gzip data.txt')
#
# Zlib is faster (in-process, no fork) and works anywhere Ruby runs.
#
# Thinking in Ruby
#
# Zlib brings gzip compression directly into Ruby's process space — no subprocess,
# no shelling out to gzip. This is a recurring Ruby philosophy: common operations
# should be library calls, not system commands. By providing Zlib::GzipWriter and
# Zlib::GzipReader as IO-like objects, Ruby lets you compress data streams using
# the same patterns you use for file I/O, making compression a transparent layer
# rather than a separate tool.
