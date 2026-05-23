#!/usr/bin/env ruby
# frozen_string_literal: true

# dup_clone.rb — freeze, clone (copies freeze + singleton), dup (doesn't)

# freeze: object becomes immutable
s = 'hello'; s.freeze
p s.frozen?             # => true
# s << ' world'          # => FrozenError

# clone: copies frozen state and singleton methods
original = 'test'
original.define_singleton_method(:custom) { "I'm custom" }
original.freeze
cloned = original.clone
p cloned.frozen?                # => true
p cloned.respond_to?(:custom)   # => true

# dup: does NOT copy frozen state or singleton methods
duplicated = original.dup
p duplicated.frozen?                # => false
p duplicated.respond_to?(:custom)   # => false
duplicated << 'ing'                 # works fine

# Both clone and dup are SHALLOW (nested objects are shared)
original = [[1, 2], [3, 4]]
cloned = original.clone
original[0] << 3
p cloned[0]  # => [1, 2, 3] — shared reference changed!

# clone(freeze: false) — Ruby 2.4+
frozen = 'hello'.freeze
unfrozen = frozen.clone(freeze: false)
p unfrozen.frozen?  # => false
unfrozen << ' world'

# Deep copy with Marshal
original = { a: [1, 2], b: { c: 3 } }
deep = Marshal.load(Marshal.dump(original))
deep[:a] << 99
p original[:a]  # => [1, 2] — unchanged, independent copy

# Identity vs Equality
a = 'hello'; b = 'hello'; c = a
p a.equal?(b)   # => false (different object_id)
p a.equal?(c)   # => true  (same object)
p a == b        # => true  (same value)

