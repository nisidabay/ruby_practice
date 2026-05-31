#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_set_vs_array.rb — O(1) vs O(n) lookups
require "set"

words = Array.new(100_000) { |i| "word_#{i}" }
words += %w[zygote aardvark python ruby]
set = words.to_set

# Membership: Set uses O(1) hash lookup, Array does O(n) scan
puts "Array: #{words.include?("zygote")}"
puts "Set:   #{set.include?("zygote")}"

# Dedup: Set is effortless
dupes = %w[foo bar foo baz bar qux]
unique = dupes.to_set.to_a.sort
puts "Unique: #{unique.inspect}"

# Hash keys == Set semantics
config = {"debug" => true, "env" => "prod"}
puts "Has debug? #{config.key?("debug")}"
