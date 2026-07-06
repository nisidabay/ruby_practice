#!/usr/bin/env ruby
# frozen_string_literal: true

# define_method.rb — create methods at runtime from data
class Report
  %w[cpu memory disk].each do |metric|
    define_method(metric) do
      "Checking #{metric}..."
    end
  end
end

r = Report.new
puts r.cpu      # => "Checking cpu..."
puts r.memory   # => "Checking memory..."
puts r.disk     # => "Checking disk..."

# Thinking in Ruby
#
# define_method creates methods at runtime from data — iterating over
# an array of metric names and generating cpu/memory/disk methods with
# one loop. This is Ruby's answer to "repeat this method body for each
# name in a list" — no code generation, no macros, just a method that
# defines methods.
