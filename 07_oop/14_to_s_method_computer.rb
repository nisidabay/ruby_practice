#!/usr/bin/env ruby
# frozen_string_literal: true

# to_s_method_computer.rb — custom string representation

class Computer
  def initialize(cpu = 'Intel i7', memory = 64, storage = '2 TB')
    @cpu = cpu
    @memory = memory
    @storage = storage
  end

  def to_s
    "A #{@cpu} computer with #{@memory}GB RAM, #{@storage} storage"
  end
end

puts Computer.new
puts Computer.new('M3', 32, '1 TB')

