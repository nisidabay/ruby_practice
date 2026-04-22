#!/usr/bin/env ruby
# frozen_string_literal: true

#
# **Key Purpose:** Aggregation. It is used for calculating sums, products,
# finding maximum/minimum values, or transforming an array into a Hash or a
# string.

p [10, 20, 30, 40, 50].reduce(0) { |sum, value| sum + value }

color_counts = %w[Red Blue Red].each_with_object({}) do |value, counts|
  if counts[value].nil?
    counts[value] = 1
  else
    counts[value] += 1
  end
end
p color_counts
