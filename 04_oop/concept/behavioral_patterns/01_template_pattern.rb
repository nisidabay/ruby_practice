#!/usr/bin/env ruby
# frozen_string_literal: true

# template_pattern.rb — algorithm skeleton, subclasses fill in the steps

class ReportBuilder
  def build_report
    data = fetch_data
    formatted = format_data(data)
    export(formatted)
  end

  protected

  def fetch_data
    raise NotImplementedError
  end

  def format_data(data)
    raise NotImplementedError
  end

  def export(formatted)
    raise NotImplementedError
  end
end

class CSVReport < ReportBuilder
  def fetch_data = %w[Alice Bob Charlie]
  def format_data(data) = data.join(',')
  def export(formatted)  = puts("📄 CSV Export: #{formatted}")
end

class HTMLReport < ReportBuilder
  def fetch_data = %w[Alice Bob Charlie]
  def format_data(data) = "<ul>#{data.map { |n| "<li>#{n}</li>" }.join}</ul>"
  def export(formatted)  = puts("🌐 HTML Export: #{formatted}")
end

CSVReport.new.build_report
HTMLReport.new.build_report

