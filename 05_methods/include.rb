#!/usr/bin/env ruby
# frozen_string_literal: true

# include.rb — check if a string contains a substring

# WITHOUT include? — regex or manual scan:
#
#   path = "/api/v1/users"
#   path =~ /\/api/    # => truthy, but regex for substring is overkill
#   path["/api"]       # => returns substring, not boolean — easy to misuse
#
# WITH include? — clean boolean:

p "/api/v1/users".include?("/api")     # => true
p "/api/v1/users".include?("/admin")   # => false
