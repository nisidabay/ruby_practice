#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Gems & Bundler practice

puts '=== Exercise 1: List installed gems ==='
puts "Ruby #{RUBY_VERSION}"
puts "Gem count: #{Gem::Specification.count}"

puts "\n=== Exercise 2: Find a specific gem ==="
spec = Gem::Specification.find_by_name('json')
puts "#{spec.name} #{spec.version}"
puts "  Summary: #{spec.summary}"

puts "\n=== Exercise 3: Gem dependencies ==="
spec.dependencies.each do |dep|
  puts "  depends on: #{dep.name} #{dep.requirement}"
end

puts "\n=== Exercise 4: Version comparison ==="
v1 = Gem::Version.new('1.2.3')
v2 = Gem::Version.new('2.0.0')
puts "1.2.3 < 2.0.0? #{v1 < v2}"

puts "\n=== Exercise 5: Requirement satisfaction ==="
req = Gem::Requirement.new('~> 1.2')
puts "~> 1.2 satisfied by 1.2.5? #{req.satisfied_by?(Gem::Version.new('1.2.5'))}"
puts "~> 1.2 satisfied by 2.0.0? #{req.satisfied_by?(Gem::Version.new('2.0.0'))}"

puts "\n=== Exercise 6: Gem paths ==="
puts "Gem paths:"
Gem.path.each { |p| puts "  #{p}" }
