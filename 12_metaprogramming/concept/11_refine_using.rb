#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Monkey-patching is global and dangerous. You want to extend a class
# but only in YOUR code — not affect the whole program.
# Example: Add a to_bool method to Config, but only in this file.
#
# Solution: refine + using — scoped monkey patching (Ruby 2.0+).
# Visibility: Refinements are only active where `using` is called.

class Config
  def initialize
    @options = { debug: 1 }  # stored as integer, not boolean
  end

  attr_reader :options
end

module ConfigRefinements
  refine Config do
    def debug?
      @options[:debug] == 1
    end
  end
end

# Activate the refinement — only in this scope:
using ConfigRefinements

config = Config.new
puts config.debug?  # => true  (refinement active here)

# Usage: Outside this file, Config has NO debug? method.
# The refinement is scoped — it doesn't leak.

# This could also be done like this:
# Traditional monkey-patching (global, dangerous):
#
#   class Config
#     def debug?
#       @options[:debug] == 1
#     end
#   end
#
# This changes Config EVERYWHERE in the program. Other code might break.
# Use refine/using when you need the extension but don't own the class.

# Thinking in Ruby
#
# Refinements solve one of Ruby's oldest tensions: monkey-patching power vs.
# global contamination. They let you reopen classes safely — the changes only
# apply where `using` is called. This is Ruby growing up without losing its
# flexibility: the dynamic you love, scoped to where you need it.
