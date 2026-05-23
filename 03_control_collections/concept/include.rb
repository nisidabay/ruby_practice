#!/usr/bin/env ruby
# frozen_string_literal: true

# include.rb — check membership without a loop

# WITHOUT include? — write your own check every time:
#
#   endpoints = %w[/api/v1 /api/v2 /admin]
#   path = "/admin"
#   found = false
#   endpoints.each { |e| found = true if e == path }
#   puts found  # true — but 5 lines for a yes/no question
#
# WITH include? — one method call:

endpoints = %w[/api/v1 /api/v2 /admin]

p endpoints.include?("/admin")       # => true
p endpoints.include?("/api/v3")      # => false
