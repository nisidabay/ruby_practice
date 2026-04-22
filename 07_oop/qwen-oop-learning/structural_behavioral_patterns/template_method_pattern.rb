#!/usr/bin/env ruby

# Template Method Pattern — Define Skeleton of an Algorithm
# Core Idea: Define the skeleton of an algorithm in a base class, but let
# subclasses override specific steps without changing the algorithm's structure.


# =============================================================================
# 1. THE ABSTRACT BASE CLASS
# =============================================================================
# This defines the template method (the algorithm skeleton) and abstract steps.

class DataProcessor
  # This is the TEMPLATE METHOD - it defines the algorithm structure
  def process(file_path)
    puts "\n=== Starting Processing ==="
    validate_file(file_path)
    data = read_data(file_path)
    data = transform(data)
    write_output(data)
    puts "=== Processing Complete ===\n\n"
  end

  # Hook: Optional step that subclasses can override
  def validate_file(file_path)
    puts "[Validating file: #{file_path}]"
    raise "File not found" unless File.exist?(file_path)
  end

  # Abstract step 1: Must be implemented by subclasses
  def read_data(file_path)
    raise NotImplementedError, "Subclasses must implement read_data()"
  end

  # Abstract step 2: Must be implemented by subclasses
  def transform(data)
    raise NotImplementedError, "Subclasses must implement transform()"
  end

  # Abstract step 3: Must be implemented by subclasses
  def write_output(data)
    raise NotImplementedError, "Subclasses must implement write_output()"
  end
end


# =============================================================================
# 2. CONCRETE IMPLEMENTATIONS
# =============================================================================
# Each subclass implements the steps differently, but uses the same algorithm.

class CSVProcessor < DataProcessor
  def read_data(file_path)
    puts "[Reading CSV file...]"
    # Simulate reading CSV
    File.readlines(file_path).map { |line| line.strip.split(",") }
  end

  def transform(data)
    puts "[Transforming CSV data: converting to uppercase]"
    data.map { |row| row.map { |cell| cell.upcase } }
  end

  def write_output(data)
    puts "[Writing transformed CSV data]"
    puts "Output: #{data.inspect}"
  end
end

class JSONProcessor < DataProcessor
  def read_data(file_path)
    puts "[Reading JSON file...]"
    # Simulate reading JSON
    require "json"
    JSON.parse(File.read(file_path))
  end

  def transform(data)
    puts "[Transforming JSON data: adding processed flag]"
    data["processed"] = true
    data["timestamp"] = Time.now.to_s
    data
  end

  def write_output(data)
    puts "[Writing transformed JSON data]"
    puts "Output: #{data.to_json}"
  end
end

class XMLProcessor < DataProcessor
  def read_data(file_path)
    puts "[Reading XML file...]"
    # Simulate reading XML (in real code, use Nokogiri)
    "<root><item>Sample</item></root>"
  end

  def transform(data)
    puts "[Transforming XML data: adding attributes]"
    data.gsub("<item>", "<item processed='true'>")
  end

  def write_output(data)
    puts "[Writing transformed XML data]"
    puts "Output: #{data}"
  end
end


# =============================================================================
# 3. HOOKS EXAMPLE
# =============================================================================
# Hooks are optional steps that subclasses can override for customization.

class ReportGenerator
  # Template method with hooks
  def generate_report(title, data)
    puts "\n=== Generating Report ==="
    setup
    write_header(title)
    write_body(data)
    write_footer
    cleanup
    puts "=== Report Complete ===\n"
  end

  # Hook: Optional setup step (default does nothing)
  def setup
    # Subclasses can override to add setup logic
  end

  def write_header(title)
    puts "[Header: #{title}]"
    puts "-" * 40
  end

  def write_body(data)
    raise NotImplementedError, "Subclasses must implement write_body()"
  end

  def write_footer
    puts "-" * 40
    puts "[Generated on: #{Time.now.strftime("%Y-%m-%d %H:%M")}]"
  end

  # Hook: Optional cleanup step (default does nothing)
  def cleanup
    # Subclasses can override to add cleanup logic
  end
end

class PDFReport < ReportGenerator
  def setup
    puts "[Initializing PDF engine...]"
  end

  def write_body(data)
    puts "[Writing PDF body with #{data.length} items]"
    data.each { |item| puts "  - #{item}" }
  end

  def cleanup
    puts "[Closing PDF document...]"
  end
end

class HTMLReport < ReportGenerator
  def write_body(data)
    puts "[Writing HTML body with #{data.length} items]"
    puts "<ul>"
    data.each { |item| puts "  <li>#{item}</li>" }
    puts "</ul>"
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Template Method Pattern Demo ===\n\n"

# Create test data files
File.write("/tmp/test.csv", "name,age,city\nalice,30,nyc\nbob,25,la")
File.write("/tmp/test.json", '{"name": "Charlie", "age": 35}')

puts "--- Processing CSV ---"
csv_processor = CSVProcessor.new
csv_processor.process("/tmp/test.csv")

puts "--- Processing JSON ---"
json_processor = JSONProcessor.new
json_processor.process("/tmp/test.json")

puts "--- Generating PDF Report ---"
pdf_report = PDFReport.new
pdf_report.generate_report("Monthly Sales", ["Product A: $1000", "Product B: $2000"])

puts "--- Generating HTML Report ---"
html_report = HTMLReport.new
html_report.generate_report("User List", ["Alice", "Bob", "Charlie"])

# Cleanup test files
File.delete("/tmp/test.csv")
File.delete("/tmp/test.json")

puts "\n=== Key Takeaway ==="
puts "The algorithm structure is defined once in the base class."
puts "Subclasses only customize the steps they care about."
puts "This is the Open/Closed Principle in action!"
