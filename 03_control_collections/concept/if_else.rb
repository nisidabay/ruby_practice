#!/usr/bin/env ruby
# frozen_string_literal: true

# if_else.rb — multi-way branching without nested ternaries

# WITHOUT if/elsif — ternaries get unreadable after 2 branches:
#
#   status = 404
#   label = status == 200 ? "OK" : status == 404 ? "Not Found" : "Unknown"
#   # already hard to read — add a third branch and it's chaos
#
# WITH if/elsif/else — flat, readable, no nesting:

def http_label(status)
  if status == 200
    "OK"
  elsif status == 404
    "Not Found"
  elsif status == 500
    "Server Error"
  else
    "Unknown (#{status})"
  end
end

puts http_label(200)    # => OK
puts http_label(404)    # => Not Found
puts http_label(302)    # => Unknown (302)
