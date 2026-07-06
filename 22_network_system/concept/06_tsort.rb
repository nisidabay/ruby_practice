#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Sort tasks with dependencies — what order should things run?
# Example: A build pipeline: compile depends on generate, which depends on configure.
#
# Solution: TSort (stdlib) — topological sorting of dependency graphs.
# Visibility: `require 'tsort'`. Include TSort, define tsort_each_node and tsort_each_child.

require 'tsort'

# Define a dependency graph
class BuildGraph
  include TSort

  def initialize
    @deps = {
      'deploy'  => ['compile', 'test'],
      'compile' => ['generate'],
      'generate' => ['configure'],
      'test'    => ['compile'],
      'configure' => []
    }
  end

  def tsort_each_node(&block)
    @deps.each_key(&block)
  end

  def tsort_each_child(node, &block)
    @deps[node].each(&block)
  end
end

graph = BuildGraph.new
puts 'Build order:'
graph.tsort.each { |step| puts "  #{step}" }
# => configure → generate → compile → test → deploy

# Usage: Detect circular dependencies
begin
  circular = { 'a' => ['b'], 'b' => ['a'] }
  # TSort would raise TSort::Cyclic
  puts "\nCircular dependency would raise TSort::Cyclic"
rescue => e
  puts "Error: #{e}"
end

# This could also be done like this:
# Manual sorting (works for simple cases):
#
#   order = []
#   while order.size < deps.size
#     ready = deps.keys.select { |k| (deps[k] - order).empty? }
#     order.concat(ready - order)
#   end
#
# TSort handles edge cases (cycles, disconnected graphs) correctly.
#
# Thinking in Ruby
#
# TSort brings topological sorting into Ruby's standard library as a mixin — any
# class can become a dependency graph by implementing two methods. This is Ruby's
# answer to a classic systems problem: "in what order do these tasks run?" Instead
# of requiring external graph libraries, Ruby provides the algorithm in stdlib
# and lets you integrate it into your domain model through a minimal interface.
# The cyclic dependency detection is a bonus that saves hours of debugging.
