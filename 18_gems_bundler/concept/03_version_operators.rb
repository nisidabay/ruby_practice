#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want to specify gem versions precisely — not just "latest."
# Example: "I need json >= 2.5 but < 3.0, and exactly minitest 5.15."
#
# Solution: Version operators in Gemfile: =, >=, ~>, <, >, <=.
# Visibility: ~> (pessimistic) is the most common — "allow patches, not majors."

puts 'Version operators in Gemfile:'
puts '  gem "foo", "= 1.0"    # exactly 1.0'
puts '  gem "foo", ">= 1.0"   # 1.0 or higher'
puts '  gem "foo", "~> 1.0"   # >= 1.0, < 2.0  (same major)'
puts '  gem "foo", "~> 1.2.3" # >= 1.2.3, < 1.3 (same minor)'
puts '  gem "foo", "< 2.0"    # anything below 2.0'

# Demonstrate ~> logic in pure Ruby:
def pessimistic_match(requested, available)
  parts = requested.split('.').map(&:to_i)
  if parts.length == 2
    min = requested
    max = "#{parts[0] + 1}.0"
  else
    min = requested
    max = "#{parts[0]}.#{parts[1] + 1}.0"
  end
  Gem::Version.new(available) >= Gem::Version.new(min) &&
    Gem::Version.new(available) < Gem::Version.new(max)
end

puts "\n~> 1.2 matches:"
%w[1.2.0 1.2.5 1.2.99 1.3.0 2.0.0].each do |v|
  ok = pessimistic_match('1.2', v) ? '✓' : '✗'
  puts "  #{ok} #{v}"
end
# ✓ 1.2.0, ✓ 1.2.5, ✓ 1.2.99, ✗ 1.3.0, ✗ 2.0.0

# This could also be done like this:
# Gem::Requirement does this natively:
#
#   req = Gem::Requirement.new('~> 1.2')
#   req.satisfied_by?(Gem::Version.new('1.2.5'))  # => true
#   req.satisfied_by?(Gem::Version.new('2.0.0'))  # => false
