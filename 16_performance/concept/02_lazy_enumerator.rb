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
