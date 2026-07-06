#!/usr/bin/env ruby
# frozen_string_literal: true

# manual_getters_airplane.rb — manual getters (use attr_reader normally)

class Airplane
  def initialize
    @maker = "Boeing"
    @model = 757
    @seats = 60
  end

  def maker; @maker; end
  def model; @model; end
  def seats; @seats; end
end

airplane = Airplane.new
puts airplane.maker, airplane.model, airplane.seats

# Prefer: attr_reader :maker, :model, :seats


# Thinking in Ruby
#
# Manual getter methods (def maker; @maker; end) show what attr_reader
# generates automatically. Ruby's metaprogramming starts here: attr_*
# methods ARE code — they're just shorthand for the same Ruby code you
# write by hand. Understanding the manual version demystifies the macro.
