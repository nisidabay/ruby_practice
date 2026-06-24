#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You use (jpg|jpeg) to match extensions, but the group captures data you don't need.
# Example: Parsing filenames — you want the extension, not "which variant matched".
# Solution: (?:...) groups without capturing. Same grouping power, no side effects.
# Visibility: Use for alternatives inside a pattern when you only care about outer groups.

files = ['photo.jpg', 'image.jpeg', 'document.png', 'icon.svg']

# Non-capturing: the (?:jpe?g) group matches but doesn't store — capture [1] is the full ext
files.each do |f|
  if f =~ /\.(jpe?g|png|svg)$/
    puts "#{f} is an image (type: #{$1})"
  end
end

# Without non-capturing, you'd accidentally capture jpe?g internals:
bad = /\.(jpg|jpeg|png|svg)$/  # Works, but wastes captures if you had more structure

# Realer example: matching version tags like v2.4.1-stable or v2.4.1-rc1
# You want the version number, but (stable|rc1) is just noise in the capture
tag = 'v2.4.1-rc1'
if tag =~ /v(\d+\.\d+\.\d+)(?:-rc\d+|-stable)?/
  puts "Version: #{$1}" # => 2.4.1 — the rc suffix was matched but not captured
end

# This could also be done like this:
# Use (jpg|jpeg) — same result, but the alternative group clutters $1..$N.
# Non-capturing keeps match indices clean for the captures you actually care about.
