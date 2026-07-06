#!/usr/bin/env ruby
# frozen_string_literal: true

# regular_expressions.rb — sub (first), gsub (all), scan (iterate)

# sub: replace first match only
puts 'http://example.com/http'.sub('http', 'https') # => https://example.com/http

# gsub: replace all matches
puts 'http://example.com/http'.gsub('http', 'https') # => https://example.com/https

# scan: extract all matches — useful for parsing
'Deploy v2.4.1 to staging (2026-05-10)'.scan(/\d+\.\d+\.\d+/) { |v| puts v }

# Thinking in Ruby
#
# sub, gsub, and scan form Ruby's regex trinity: replace-first, replace-all,
# and iterate-matches. They're methods on String, not standalone functions,
# so regex operations chain naturally with other method calls. The block
# form of gsub/scan also doubles as an iterator — two patterns, one API.
