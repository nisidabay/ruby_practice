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

