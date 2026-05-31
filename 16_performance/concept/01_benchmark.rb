#!/usr/bin/env ruby
# frozen_string_literal: true

# 01_benchmark.rb — measure and compare code performance
require "benchmark"

data = (1..1_000_000).to_a
require "set"
set = data.to_set
test_values = Array.new(1000) { rand(2_000_000) }

Benchmark.bm(25) do |x|
  x.report("Array#include? (1k lookups)") do
    test_values.each { |v| data.include?(v) }
  end

  x.report("Set#include? (1k lookups)") do
    test_values.each { |v| set.include?(v) }
  end
end
