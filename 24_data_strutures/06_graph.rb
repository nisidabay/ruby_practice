#!/usr/bin/env ruby
# frozen_string_literal: true

# 06_graph.rb — Graph: adjacency list + BFS traversal
#
# WITHOUT graph structure — implicit connections, hard to traverse:
#
#   edges = [["A","B"], ["A","C"]]  # finding neighbors requires scanning all edges
#
# WITH adjacency list — O(1) lookup for neighbors:

require "set"

class Graph
  def initialize
    @adj = Hash.new { |h, k| h[k] = [] }
  end

  def add_edge(from, to)
    @adj[from] << to
    @adj[to] << from   # undirected
  end

  def neighbors(node); @adj[node]; end

  def bfs(start)
    visited = Set.new
    queue = [start]
    order = []

    while queue.any?
      node = queue.shift
      next if visited.include?(node)
      visited << node
      order << node
      @adj[node].each { |n| queue << n unless visited.include?(n) }
    end
    order
  end
end

g = Graph.new
g.add_edge("DB", "API")
g.add_edge("API", "Web")
g.add_edge("API", "Worker")
g.add_edge("Web", "CDN")

puts "API neighbors: #{g.neighbors("API")}"             # => ["DB", "Web", "Worker"]
puts "BFS from DB:   #{g.bfs("DB").join(' → ')}"        # => DB → API → Web → Worker → CDN
