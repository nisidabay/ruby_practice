#!/usr/bin/env ruby

# Problem: You want to define the skeleton of an algorithm but let subclasses customize specific steps.
# Example: A report builder that always follows: fetch data → format → export, but each format differs.
#
# Solution: Use a template method that calls abstract methods for the customizable steps.
# Visibility: Template method is public, customization points are protected/abstract.

class ReportBuilder
  # Template method - defines the algorithm skeleton
  def build_report
    data = fetch_data
    formatted = format_data(data)
    export(formatted)
  end

  protected

  def fetch_data
    raise NotImplementedError, "Subclasses must implement fetch_data"
  end

  def format_data(data)
    raise NotImplementedError, "Subclasses must implement format_data"
  end

  def export(formatted)
    raise NotImplementedError, "Subclasses must implement export"
  end
end

class CSVReport < ReportBuilder
  def fetch_data
    ["Alice", "Bob", "Charlie"]
  end

  def format_data(data)
    data.join(",")
  end

  def export(formatted)
    puts "📄 CSV Export: #{formatted}"
  end
end

class HTMLReport < ReportBuilder
  def fetch_data
    ["Alice", "Bob", "Charlie"]
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

# This could also be done like this:
# If you want to customize behavior at runtime without creating subclasses,
# pass blocks/lambdas to the template method:
#
# class ReportBuilder
#   def build_report(&format_block)
#     data = fetch_data
#     formatted = format_block.call(data) if format_block
#     export(formatted)
#   end
# end
