#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Optparse
# This file contains Ruby code for optparse.

# optparse examples
require 'optparse'

options = {}

OptionParser.new do |opts|
  opts.banner = 'Usage: greet.rb [options] NAME'
  opts.on('-v', '--verbose', 'Print more information') do
    options[:verbose] = true
  end

  opts.on('-n', '--name NAME', 'Who to greet (required)') do |name|
    options[:name] = name
  end

  opts.on_tail('-h', '--help', 'Show this help') do
    puts opts
    exit
  end
end.parse!

puts "Hello, #{options[:name] || 'world'}!"
puts 'Verbose mode ON!' if options[:verbose]
