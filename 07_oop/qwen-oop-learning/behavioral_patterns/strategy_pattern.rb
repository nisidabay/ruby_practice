#!/usr/bin/env ruby
# Core Idea: Encapsulate different algorithms or behaviors so you can swap them
# at runtime - without changing the classes that uses them.

# class Sorter
#   def initialize(strategy)
#     @strategy = strategy
#   end
#
#   def sort(data)
#     @strategy.call(data)
#   end
# end
#
# # Strategies as Lambdas (simple!)
# quick_sort = ->(arr) { arr.sort }
# reverse_sort = ->(arr) { arr.sort.reverse }
#
# sorter = Sorter.new(quick_sort)
# p sorter.sort([3, 1, 2])  # => [1, 2, 3]
#
# sorter = Sorter.new(reverse_sort)
# p sorter.sort([3, 1, 2])  # => [3, 2, 1]

class ReportGenerator
  def initialize(formatter)
    @formatter = formatter
  end

  def generate(data)
    @formatter.call(data)
  end

end

# Formatter strategies
pdf_formatter = ->(data) { puts "PDF Report: #{data.inspect}" }
html_formatter = ->(data) { puts "HTML Report: #{data.inspect}" }

# Sample data
report_data = { title: "Sales Q1", values: [100, 200, 300] }

# Generate reports with different strategies
generator = ReportGenerator.new(pdf_formatter)
puts generator.generate(report_data)

generator = ReportGenerator.new(html_formatter)
puts generator.generate(report_data)

