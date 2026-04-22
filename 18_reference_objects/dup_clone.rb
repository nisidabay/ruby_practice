#!/usr/bin/env ruby

# Ruby Object Copying and Immutability: `clone`, `dup`, and `freeze`

# Once frozen, an object cannot be modified.

str = 'hello'
str.freeze
# str << " world"  # => FrozenError: can't modify frozen String

arr = [1, 2, 3]
arr.freeze
# arr << 4         # => FrozenError: can't modify frozen Array

# Check if an object is frozen:

str.frozen? # => true
arr.frozen? # => true

# clone copies the object's state, including whether it's frozen and any
# singleton methods.

original = 'test'
original.define_singleton_method(:custom) { "I'm custom" }
original.freeze

cloned = original.clone

puts cloned.frozen? # => true
puts cloned.respond_to?(:custom) # => true
puts cloned.custom # => "I'm custom"

original = [1, 2, 3]
original.freeze
cloned = original.clone

puts cloned.frozen? # => true
# cloned << 4              # => FrozenError

# dup – Shallow Copy Without Frozen State or Singleton Methods
# dup creates a new object but does not copy the frozen state or singleton methods.

original = 'test'
original.define_singleton_method(:custom) { "I'm custom" }
original.freeze

duplicated = original.dup

puts duplicated.frozen? # => false
puts duplicated.respond_to?(:custom) # => false
duplicated << 'ing' # Works fine

original = [1, 2, 3]
original.freeze
duplicated = original.dup

puts duplicated.frozen? # => false
duplicated << 4 # Works fine

# Shallow Copy Behavior with Nested Objects
# Both `clone` and `dup` perform shallow copies. Nested objects are shared.

original = [[1, 2], [3, 4]]
cloned = original.clone
duplicated = original.dup

original[0] << 3

puts cloned[0] # => [1, 2, 3]
puts duplicated[0] # => [1, 2, 3]

# clone(freeze: false) - Ruby 2.4+
# Allows cloning while skipping the frozen state

original = 'hello'
original.freeze

cloned_unfrozen = original.clone(freeze: false)
puts cloned_unfrozen.frozen? # => false
cloned_unfrozen << ' world'  # Works fine

# Deep Copy with Marshal
# Shallow copies share nested objects; deep copies create independent copies

original = { a: [1, 2], b: { c: 3 } }
shallow = original.dup
shallow[:a] << 3
puts original[:a] # => [1, 2, 3] - shared reference!

deep = Marshal.load(Marshal.dump(original))
deep[:a] << 99
puts original[:a] # => [1, 2, 3] - unchanged, independent copy

# Object Identity: object_id, equal?, and ==
# - object_id: unique identifier for each object
# - equal?: true only if same object (same object_id)
# - ==: value equality (can be overridden)

a = 'hello'
b = 'hello'
c = a

puts a.equal?(b) # => false (different objects)
puts a.equal?(c) # => true (same reference)

puts a == b # => true (same value)
