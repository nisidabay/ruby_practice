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
