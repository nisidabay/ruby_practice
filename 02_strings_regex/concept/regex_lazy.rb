#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Greedy quantifiers eat too much — .+ matches from first < to last >.
# Example: Parsing HTML tags or any delimited text where multiple matches exist.
# Solution: Lazy quantifiers (+?, *?) stop at the first valid end, not the last.
# Visibility: Essential when matching inside paired delimiters (tags, quotes, brackets).

html = '<b>bold</b> and <i>italic</i>'

# Greedy: .+ between < and > eats from first < to last > — one big match
greedy = html.scan(/<.+>/)
puts "Greedy: #{greedy}" # => ["<b>bold</b> and <i>italic</i>"] — wrong!

# Lazy: .+? between < and > stops at each > — matches individual tags
lazy = html.scan(/<.+?>/)
puts "Lazy: #{lazy}"      # => ["<b>", "</b>", "<i>", "</i>"] — correct

# Real-world: parsing comma-separated fields from `file` command output
# Greedy /, .+,/ would match from first comma to last — lazy stops at each boundary
file_out = 'ELF 64-bit LSB executable, x86-64, version 1 (SYSV)'
tokens = file_out.scan(/\w.+?(?=,|$)/)  # lazy fields: stop at next comma or end
puts "Tokens: #{tokens.inspect}"         # => ["ELF 64-bit LSB executable", "x86-64", "version 1 (SYSV)"]

# This could also be done like this:
# /<.+>/ — deceptively simple, but wrong when there are multiple tags.
# Lazy quantifiers are the default choice for delimited text; greed is opt-in.

# Thinking in Ruby
#
# Lazy quantifiers (+?, *?) are essential for delimited text — they stop
# at the first valid end rather than consuming everything up to the last
# one. Ruby's regex engine defaults to greediness but makes lazy matching
# a single ? away, giving you full control without verbose workarounds.
