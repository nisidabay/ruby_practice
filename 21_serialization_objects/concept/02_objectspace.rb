#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to know what objects are alive in memory — count them, find them.
# Example: Debug a memory leak: "How many String objects exist right now?"
#
# Solution: ObjectSpace (stdlib) — introspection of all live Ruby objects.
# Visibility: `require 'objspace'`. Can iterate every object in the process.

require 'objspace'

# Count objects by class
puts 'Live objects by class:'
counts = ObjectSpace.count_objects
puts "  Total: #{counts[:TOTAL]}"
puts "  Strings: #{counts[:T_STRING]}"
puts "  Arrays: #{counts[:T_ARRAY]}"
puts "  Hashes: #{counts[:T_HASH]}"

# Usage: Find specific objects
strings = []
ObjectSpace.each_object(String) do |obj|
  strings << obj if obj.length > 50
  break if strings.size >= 3
end
puts "\nLong strings in memory:"
strings.each { |s| puts "  #{s[0..40]}..." }

# Usage: Memory size of an object
str = 'Hello Ruby!' * 100
puts "\nMemory: '#{str[0..20]}...' = #{ObjectSpace.memsize_of(str)} bytes"

# This could also be done like this:
# GC.stat — garbage collector stats (no ObjectSpace needed):
#
#   GC.stat  # => {count: 42, heap_allocated_pages: 100, ...}
#
# ObjectSpace is for deep introspection. GC.stat is for quick GC health checks.
#
# Thinking in Ruby
#
# ObjectSpace is Ruby's window into its own memory — you can count, find, and
# measure every live object in the process. This level of introspection is rare
# in managed languages and reflects Ruby's commitment to developer visibility.
# While you won't use ObjectSpace daily, it's invaluable when debugging memory
# leaks or understanding object lifetimes. Ruby doesn't hide the runtime from you;
# it gives you tools to inspect it.
