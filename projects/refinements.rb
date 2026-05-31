#!/usr/bin/env ruby
# frozen_string_literal: true

# refinements.rb — scoped monkey patching (safer than reopening classes)

module StringExtras
  refine String do
    def palindrome?
      self == reverse
    end

    def word_count
      split.count
    end
  end
end

class TextProcessor
  using StringExtras

  def analyze(text)
    puts "Words: #{text.word_count}"
    puts "Palindrome? #{text.palindrome?}"
  end
end

TextProcessor.new.analyze('racecar')
# 'racecar'.palindrome? # => NoMethodError — refinement only valid in TextProcessor scope

# Scope rules: refinements are lexically scoped, not inherited
module Debug
  refine Object do
    def debug_inspect
      "<#{self.class}: #{self}>"
    end
  end
end

class A
  using Debug
  def self.show(obj) = obj.debug_inspect  # works
end

class B
  def self.show(obj) = obj.inspect        # Debug not available here
end

puts A.show('test')  # => <String: test>

# combining: use at file level
module TimeRefinements
  refine Integer do
    def seconds = self
    def minutes = self * 60
    def hours   = self * 3600
  end
end

using TimeRefinements
puts 5.minutes  # => 300
puts 2.hours    # => 7200

