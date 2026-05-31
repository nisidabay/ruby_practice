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
