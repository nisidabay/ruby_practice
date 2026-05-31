#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — dup, clone, freezing, object_id

# --- Show that assignment doesn't copy — it shares the object ---
a = ["apple", "banana"]
b = a
b << "cherry"
puts "a: #{a}"  # => ["apple", "banana", "cherry"] — changed through b!
puts "same object? #{a.object_id == b.object_id}"  # => true

# --- dup creates a shallow copy ---
original = [1, 2, 3]
copy = original.dup
copy << 4
puts "original: #{original}"  # => [1, 2, 3] (unchanged)
puts "copy: #{copy}"          # => [1, 2, 3, 4]

# --- freeze prevents modification ---
frozen = "hello".freeze
# frozen << " world"  # => FrozenError — uncomment to see it fail

# --- clone vs dup: clone copies frozen state, dup doesn't ---
x = "hello".freeze
x_dup = x.dup
x_clone = x.clone
puts "dup frozen? #{x_dup.frozen?}"     # => false
puts "clone frozen? #{x_clone.frozen?}" # => true
