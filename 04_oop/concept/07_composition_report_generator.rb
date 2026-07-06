#!/usr/bin/env ruby
# frozen_string_literal: true

# 07_composition_report_generator.rb — child created inside parent, dies with it

# WITHOUT composition — pass the generator from outside, shared ownership:
#
#   generator = PdfGenerator.new
#   report = Report.new("Q1 Sales", generator)
#   # generator lives on after report destroyed — who owns it?
#
# WITH composition — parent creates AND owns the child lifecycle:

class PdfGenerator
  def generate(data)
    "PDF (#{data[:pages]} pages)"
  end
end

class Report
  def initialize(title, data)
    @title = title
    @data = data
    @generator = PdfGenerator.new  # created here, owned by this report
  end

  def export
    puts "#{@title}: #{@generator.generate(@data)}"
  end
end

report = Report.new("Q1 Sales", {pages: 12})
report.export  # => Q1 Sales: PDF (12 pages)

report = nil   # report gone → generator gone too
puts "After report destroyed, the PdfGenerator no longer exists."

# Thinking in Ruby
#
# Composition: the child object (PdfGenerator) is created inside the
# parent (Report) and dies with it. This ownership relationship is
# enforced by lifecycle — the generator has no existence outside the
# report. In Ruby, composition is just an object created in initialize
# and referenced only by the parent.
