#!/usr/bin/env ruby

class ReportBuilder
  def initialize(data_source = nil, &default_formatter)
    @data_source = data_source || -> { [10, 20, 30] }
    @default_formatter = default_formatter || ->(d) { d.inspect }
  end

  def build_report(data_source: nil, &formatter)
    data = (data_source || @data_source).call
    formatted = (formatter || @default_formatter).call(data)
    export(formatted)
  end

  private

  def export(output)
    puts "📤 Exporting: #{output}"
  end
end

# Safe, built-in strategies
csv_data = -> { ["Alice", "Bob", "Charlie"] }
csv_format = ->(arr) { arr.join(",") }

hash_data = -> { { title: "Team", count: 3 } }
hash_format = ->(h) { h.to_s }  # ✅ .to_s always works!

# Run it
builder = ReportBuilder.new
builder.build_report(&csv_format)
builder.build_report(data_source: csv_data, &csv_format)
builder.build_report(data_source: hash_data, &hash_format)
