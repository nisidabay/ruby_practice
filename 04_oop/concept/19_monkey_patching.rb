#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to add new methods to existing Ruby classes like Array or Hash.
# Example: Add more_than_once? to Array to check if element appears multiple times.
#
# Solution: Reopen the class and define new methods (monkey patching).
# Visibility: PUBLIC - method becomes available on all instances.

# Add method to Array class
class Array
  def more_than_once?(element)
    count(element) > 1
  end
end

# Add method to Hash class
class Hash
  def common_keys_and_values
    keys & values
  end
end

# Usage: Methods now available on all Array and Hash objects
my_array = [1, 2, 2, 3]
puts my_array.more_than_once?(2)    # true
puts my_array.more_than_once?(3)    # false

my_hash = { a: 'hello', b: 'goodbye', 'goodbye' => 5 }
p my_hash.common_keys_and_values    # ["goodbye"]

my_hash2 = { a: 'hello', b: 'goodbye', 'goodbye' => 5, hello: :a }
p my_hash2.common_keys_and_values   # ["goodbye"]

# This could also be done like this:
# Use refine for localized monkey patching (Ruby 2.0+):
#
# module ArrayExtensions
#   refine Array do
#     def more_than_once?(element)
#       count(element) > 1
#     end
#   end
# end
#
# using ArrayExtensions
# [1, 2, 2, 3].more_than_once?(2)  # Works only in this scope

# Thinking in Ruby
#
# Monkey patching — reopening a class to add methods — is Ruby's most
# controversial feature. It gives tremendous power (adding methods to
# Array or Hash globally) but can conflict with gems. Ruby 2.0+'s
# Refinements (refine...using) provide scoped monkey patching, keeping
# the power while limiting the blast radius.
