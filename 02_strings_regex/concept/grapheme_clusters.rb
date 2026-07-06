#!/usr/bin/env ruby
# frozen_string_literal: true

# grapheme_clusters.rb — iterate visual characters, not bytes or codepoints
# Emoji and accented characters are multiple codepoints. Use each_grapheme_cluster
# to iterate what a human sees, not what the computer stores.

text = "café 👧🏽 résumé"

puts "chars (splits modifiers):"
text.chars.each { |c| puts "  #{c}  (bytes: #{c.bytesize})" }

puts "\neach_grapheme_cluster (correct):"
text.each_grapheme_cluster { |c| puts "  #{c}  (bytes: #{c.bytesize})" }

# Thinking in Ruby
#
# each_grapheme_cluster iterates over visual characters (graheme clusters)
# rather than codepoints or bytes — essential for proper Unicode handling.
# While many languages treat strings as byte arrays, Ruby gives you the
# abstraction that matches human perception, reflecting its design
# philosophy of programmer empathy.
