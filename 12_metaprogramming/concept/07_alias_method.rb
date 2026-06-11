#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Rename a method, or create an alias while keeping the original.
# Example: Give Config a settings alias for @options without breaking existing code.
#
# Solution: alias_method — creates a copy of a method under a new name.
# Visibility: The alias has the same visibility as the original.

class Config
  def initialize
    @options = { debug: true, cache: false }
  end

  def options
    @options
  end

  # Create an alias — both names now work:
  alias_method :settings, :options
end

config = Config.new
puts config.options   # => {debug: true, cache: false}
puts config.settings  # => {debug: true, cache: false}  (same thing)

# This could also be done like this:
# remove_method deletes a method from THIS class (inherited ones still work):
#
#   class Config
#     remove_method :settings  # settings is gone, options still works
#   end
#
# undef_method prevents that method entirely — even inherited versions:
#
#   class Config
#     undef_method :to_s  # even Object#to_s is blocked
#   end
