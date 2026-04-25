#!/usr/bin/env ruby

require 'json'

# Problem: You want to define the skeleton of an algorithm but let subclasses customize specific steps.
# Example: A report builder that always follows: fetch data → format → export, but each format differs.
#
# Solution: Use a template method that calls abstract methods for the customizable steps.
# Visibility: Template method is public, customization points are protected/abstract.
# Trade-offs:
# ⚠️ Can lead to deep inheritance hierarchies if overused
# ⚠️ Subclasses may be constrained by the template structure
# ⚠️ Consider Strategy Pattern as an alternative when you need more flexibility (composition over inheritance)

class ReportBuilder
  # Template method - defines the algorithm skeleton
  def build_report
    data = fetch_data
    formatted = format_data(data)
    export(formatted)
  end

  protected

  def fetch_data
    raise NotImplementedError, 'Subclasses must implement fetch_data'
  end

  def format_data(data)
    raise NotImplementedError, 'Subclasses must implement format_data'
  end

  def export(formatted)
    raise NotImplementedError, 'Subclasses must implement export'
  end
end

class CSVReport < ReportBuilder
  def fetch_data
    %w[Alice Bob Charlie]
  end

  def format_data(data)
    data.join(',')
  end

  def export(formatted)
    puts "📄 CSV Export: #{formatted}"
  end
end

class HTMLReport < ReportBuilder
  def fetch_data
    %w[Alice Bob Charlie]
  end

  def format_data(data)
    "<ul>#{data.map { |name| "<li>#{name}</li>" }.join}</ul>"
  end

  def export(formatted)
    puts "🌐 HTML Export: #{formatted}"
  end
end

# Usage: Create concrete subclasses for each variation
csv = CSVReport.new
csv.build_report

html = HTMLReport.new
html.build_report

# Alternative: Block-based approach (Strategy Pattern style)
# If you want to customize behavior at runtime without creating subclasses,
# pass blocks/lambdas to the template method:

require 'json'
class FlexibleReportBuilder
  def initialize(data_source)
    @data_source = data_source
  end

  def build_report(format: nil, export: nil)
    data = fetch_data
    formatted = format ? format.call(data) : data.inspect
    export_method = export || method(:default_export)
    export_method.call(formatted)
  end

  private

  def fetch_data
    @data_source.call
  end

  def default_export(formatted)
    puts "📦 Default Export: #{formatted}"
  end
end

# Usage with blocks/lambdas - no subclassing needed!
puts "\n--- Block-based Template Pattern ---"

# Define behaviors as lambdas
# user_data = -> { ["Alice", "Bob", "Charlie"] }
# json_format = ->(data) { data.to_json }
# xml_format = ->(data) { "<data>#{data.map { |n| "<item>#{n}</item>" }.join}</data>" }
# print_export = ->(formatted) { puts "🖨️  Printed: #{formatted}" }
# No arguments needed for this one
user_data = -> { %w[Alice Bob Charlie] }

# The argument 'data' moves inside the vertical bars | |
json_format = ->(data) { data.to_json }

xml_format = ->(data) { "<data>#{data.map { |n| "<item>#{n}</item>" }.join}</data>" }

print_export = ->(formatted) { puts "🖨️  Printed: #{formatted}" }
# Build different reports by composing behaviors
json_report = FlexibleReportBuilder.new(user_data)
json_report.build_report(format: json_format, export: print_export)

xml_report = FlexibleReportBuilder.new(user_data)
xml_report.build_report(format: xml_format, export: print_export)

# Mix and match at runtime!
plain_report = FlexibleReportBuilder.new(user_data)
plain_report.build_report # uses defaults
