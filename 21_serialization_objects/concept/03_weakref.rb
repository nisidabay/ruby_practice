#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Hold a reference to an object without preventing its garbage collection.
# Example: A cache that should drop entries when memory is tight.
#
# Solution: WeakRef (stdlib) — reference that doesn't keep the object alive.
# Visibility: `require 'weakref'`. The object can be collected at any time.

require 'weakref'

# Create an object and a weak reference to it
obj = 'Hello Ruby!'
weak = WeakRef.new(obj)
puts "Strong ref: #{obj}"
puts "Weak ref: #{weak.weakref_alive? ? weak : '(collected)'}"

# Usage: When the strong reference goes away, weak becomes invalid
obj = nil        # remove the strong reference
GC.start         # suggest garbage collection

begin
  puts "After GC: #{weak}"
rescue WeakRef::RefError
  puts 'After GC: (collected — RefError)'
end

# Usage: Weak cache pattern (conceptual)
puts "\nWeak cache pattern:"
puts <<~PATTERN
  cache = {}
  cache[:key] = WeakRef.new(expensive_object)
  # Later:
  begin
    obj = cache[:key]
  rescue WeakRef::RefError
    obj = expensive_object  # recompute
    cache[:key] = WeakRef.new(obj)
  end
PATTERN

# This could also be done like this:
# Regular Hash — objects never get collected:
#
#   cache[:key] = expensive_object  # stays forever
#
# WeakRef lets the GC reclaim memory when needed. Good for caches
# where recomputing is acceptable.
