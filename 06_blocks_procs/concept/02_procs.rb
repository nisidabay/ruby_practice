#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_procs.rb — stored blocks: package logic into an object

# WITHOUT Procs — repeat the same check everywhere:
#
#   [1, -2, 3].select { |n| n > 0 }
#   [5, -6, 7].select { |n| n > 0 }
#   # same logic, different arrays — you keep retyping it
#
# WITH Procs — define once, reuse:

positive = Proc.new { |n| n > 0 }
p [1, -2, 3].select(&positive)  # => [1, 3]
p [5, -6, 7].select(&positive)  # => [5, 7]

# & converts a proc to a block — same as passing the block directly.

# KEY DIFFERENCE vs lambdas: Proc return exits the ENCLOSING METHOD.
def risky
  p = Proc.new { return "Boom" }
  p.call
  "Never reached"  # dead code!
end
p risky  # => "Boom"
