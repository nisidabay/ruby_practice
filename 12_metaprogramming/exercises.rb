#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Metaprogramming practice

puts '=== Exercise 1: instance_eval ==='
class Config
  def initialize
    @options = {}
  end
end
config = Config.new
config.instance_eval { @options[:debug] = true }
puts config.instance_eval { @options[:debug] }

puts "\n=== Exercise 2: class_eval ==="
Config.class_eval do
  def debug?
    @options[:debug] == true
  end
end
puts config.debug?

puts "\n=== Exercise 3: instance_variable_get ==="
opts = config.instance_variable_get(:@options)
puts "Options: #{opts}"

puts "\n=== Exercise 4: const_set ==="
Config.const_set(:VERSION, '1.0')
puts Config::VERSION

puts "\n=== Exercise 5: binding.eval ==="
key = :debug
b = binding
puts b.eval('config.instance_eval { @options[key] }')

puts "\n=== Exercise 6: ancestors ==="
module Logger
  def log(msg)
    puts "[LOG] #{msg}"
  end
end
Config.include(Logger)
puts 'Ancestors:'
Config.ancestors.each { |a| puts "  #{a}" }
