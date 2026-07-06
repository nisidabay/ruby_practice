#!/usr/bin/env ruby
# frozen_string_literal: true

# fetch.rb — safe array access with explicit defaults or errors

# WITHOUT fetch — [] returns nil silently, bugs hide:
#
#   servers = ["web-01", "web-02"]
#   host = servers[5]          # => nil — no error!
#   puts "Deploying to #{host.upcase}"  # => NoMethodError (cryptic!)
#
# WITH fetch — out-of-range blows up immediately OR gives a default:

servers = ["web-01", "web-02"]

p servers.fetch(5, "web-fallback")   # => "web-fallback"  (explicit default)
# servers.fetch(5)                    # => IndexError (loud failure — usually what you want)
p servers[5]                          # => nil (silent — often wrong)

# Thinking in Ruby
#
# fetch is the safe accessor for arrays — it raises IndexError on
# out-of-bounds (loud failure) or returns an explicit default. The [] 
# operator returns nil silently (easy to miss). Ruby gives you both:
# fetch for contracts, [] for quick access. Choosing fetch by default
# catches bugs early.
