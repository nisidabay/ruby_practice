#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Save a Ruby object to disk and restore it later — with all its state.
# Example: Cache an API response (a Hash with nested data) to avoid re-fetching.
#
# Solution: Marshal (stdlib) — serializes Ruby objects to bytes and back.
# Visibility: Works on most Ruby objects. Cannot serialize Procs, IO, or singletons.

# Serialize: object → bytes
data = { users: [{ name: 'Alice' }, { name: 'Bob' }], cached_at: Time.now }
bytes = Marshal.dump(data)
puts "Serialized: #{data.inspect}"
puts "Bytes: #{bytes.bytesize} bytes"

# Deserialize: bytes → object
restored = Marshal.load(bytes)
puts "Restored: #{restored.inspect}"
puts "Match? #{restored == data}"  # => true (deep equality)

# Usage: Save to file
# File.write('cache.marshal', Marshal.dump(data))
# cached = Marshal.load(File.read('cache.marshal'))

# Usage: What CAN'T be serialized
begin
  Marshal.dump(proc { |x| x + 1 })
rescue TypeError => e
  puts "\nCannot serialize: #{e.message}"  # Procs, IO, Bindings
end

# This could also be done like this:
# JSON — human-readable, cross-language, but loses Ruby-specific types:
#
#   require 'json'
#   File.write('cache.json', JSON.pretty_generate(data))
#   # Time becomes a string, Symbols become Strings
#
# Marshal preserves exact Ruby types (Time, Symbol, Regexp) but is
# Ruby-only and binary (not human-readable).
#
# Thinking in Ruby
#
# Marshal is Ruby's native serialization format — it preserves exact Ruby object
# types (Symbol, Time, Regexp) that JSON and YAML would mangle. This deep object
# graph preservation reflects Ruby's reflective nature: the runtime knows how to
# serialize and deserialize its own objects with full fidelity. The trade-off is
# clear — use Marshal for Ruby-to-Ruby communication, JSON for interoperability.
