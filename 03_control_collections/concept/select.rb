#!/usr/bin/env ruby
# frozen_string_literal: true

# select.rb — keep elements that match (aka filter)

# WITHOUT select — manual if-in-a-loop:
#
#   responses = [200, 404, 200, 500, 200]
#   ok = []
#   responses.each { |code| ok << code if code == 200 }
#
# WITH select — declarative:

responses = [200, 404, 200, 500, 200]
p responses.select { |code| code == 200 }  # => [200, 200, 200]
p responses.reject { |code| code == 200 }  # => [404, 500]

# Thinking in Ruby
#
# select (and its inverse reject) filter collections declaratively — no
# empty array initialization, no conditional pushes. The block is a
# predicate that returns true for kept elements. Ruby's focus on
# expressive enumerable methods means you describe WHAT to keep, not HOW
# to build the filtered result.
