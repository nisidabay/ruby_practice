#!/usr/bin/env ruby
# frozen_string_literal: true

# 33_forwardable.rb — delegation without boilerplate
#
# WITHOUT Forwardable — write manual delegators for every method:
#
#   class Report
#     def title;       @document.title;       end
#     def author;      @document.author;      end
#     def word_count;  @document.word_count;  end
#     # 20 more one-liners...
#   end
#
# WITH Forwardable — declare what you delegate, one line per target:

require "forwardable"

class Document
  attr_reader :title, :author, :word_count, :pages
  def initialize(title, author, word_count, pages)
    @title = title; @author = author; @word_count = word_count; @pages = pages
  end
end

class Report
  extend Forwardable

  attr_reader :doc

  # def_delegators :target, :method1, :method2, ...
  def_delegators :@doc, :title, :author, :word_count

  # def_delegator  :target, :method, :alias_name
  def_delegator  :@doc, :pages, :page_count   # delegate with rename

  def initialize(doc)
    @doc = doc
  end
end

doc = Document.new("Q1 Results", "Carlos", 15000, 42)
rpt = Report.new(doc)

puts "Title:   #{rpt.title}"       # => Q1 Results (delegated to @doc.title)
puts "Author:  #{rpt.author}"      # => Carlos
puts "Words:   #{rpt.word_count}"  # => 15000
puts "Pages:   #{rpt.page_count}"  # => 42 (delegated @doc.pages → renamed)

# def_delegators for multiple methods to same target.
# def_delegator  for single method (supports renaming).
# Targets can be instance variables (@doc), methods (doc), or constants.
