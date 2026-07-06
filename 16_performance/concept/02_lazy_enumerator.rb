#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_lazy_enumerator.rb — process large datasets without loading everything
# Enumerator::Lazy chains map/select without building intermediate arrays

lines = (1..1_000_000).lazy
  .map { |n| n * 2 }
  .select { |n| n % 3 == 0 }
  .first(5)

puts lines.inspect
# Without .lazy: builds a 1M-element Array, then another 1M Array, then picks 5.
# With .lazy: processes only until 5 matches found — near-zero memory.

# Thinking in Ruby
#
# Enumerator::Lazy chains map/select without building intermediate
# arrays. Eager evaluation builds a 1M-element array for each step;
# lazy evaluation processes elements one at a time until the result
# is complete. This is Ruby's answer to large datasets: the same
# Enumerable API you already know, but streaming instead of buffering.
