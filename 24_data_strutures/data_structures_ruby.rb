#!/usr/bin/env ruby
# frozen_string_literal: true

# data_structures_ruby.rb — 8 fundamental data structures in Ruby

# ============================================================
# 1. ARRAY — O(1) access by index, O(n) insert middle
# ============================================================
cars = ["Toyota", "Mazda", "Ford", "BMW"]
p cars[2]              # => "Ford" (instant)
cars << "Tesla"        # O(1) amortized
cars.insert(1, "Honda") # O(n) — shifts everything right
p cars

# ============================================================
# 2. LINKED LIST — O(1) insert/delete, O(n) access
# ============================================================
class Node
  attr_accessor :value, :next
  def initialize(value)
    @value = value
    @next = nil
  end
end

class LinkedList
  attr_accessor :head
  def initialize
    @head = nil
  end

  def add_to_beginning(value)   # O(1)
    new_node = Node.new(value)
    new_node.next = @head
    @head = new_node
  end

  def display
    els = []
    cur = @head
    while cur
      els << cur.value
      cur = cur.next
    end
    els.join(" -> ")
  end
end

list = LinkedList.new
list.add_to_beginning("Ford")
list.add_to_beginning("Mazda")
list.add_to_beginning("Toyota")
puts list.display  # => Toyota -> Mazda -> Ford

# ============================================================
# 3. STACK — LIFO (push/pop), O(1)
# ============================================================
class Stack
  def initialize
    @stack = []
  end

  def push(v)
    @stack << v
  end

  def pop
    @stack.pop
  end

  def top
    @stack.last
  end

  def empty?
    @stack.empty?
  end
end

stack = Stack.new
stack.push("Write 'hello'")
stack.push("Write 'world'")
stack.push("Apply bold")
p stack.pop  # => "Apply bold" (undo!)
p stack.pop  # => "Write 'world'"

# ============================================================
# 4. QUEUE — FIFO (enqueue/dequeue)
# ============================================================
class Queue
  def initialize
    @q = []
  end

  def enqueue(v)
    @q << v
  end

  def dequeue
    @q.shift
  end

  def front
    @q.first
  end

  def empty?
    @q.empty?
  end
end

queue = Queue.new
queue.enqueue("Ana")
queue.enqueue("Luis")
queue.enqueue("Maria")
p queue.dequeue  # => "Ana" (first in, first out)
p queue.dequeue  # => "Luis"

# ============================================================
# 5. HASH TABLE — O(1) insert/search/delete (Ruby's Hash)
# ============================================================
phone_book = {}
phone_book["Alice"] = "555-0101"
phone_book["Bob"]   = "555-0102"
p phone_book["Alice"]           # => "555-0101" (instant lookup)
p phone_book.key?("Charlie")    # => false

# Counting pattern
words = %w[apple banana apple cherry]
counts = Hash.new(0)
words.each { |w| counts[w] += 1 }
p counts  # => {"apple"=>2, "banana"=>1, "cherry"=>1}

# ============================================================
# 6. BINARY SEARCH TREE — O(log n) search/insert
# ============================================================
class TreeNode
  attr_accessor :value, :left, :right
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BST
  attr_accessor :root
  def initialize
    @root = nil
  end

  def insert(value)
    @root = insert_node(@root, value)
  end

  def find(value)
    search_node(@root, value)
  end

  private

  def insert_node(node, value)
    return TreeNode.new(value) unless node

    if value < node.value
      node.left = insert_node(node.left, value)
    else
      node.right = insert_node(node.right, value)
    end
    node
  end

  def search_node(node, value)
    return false unless node
    return true if node.value == value

    value < node.value ? search_node(node.left, value) : search_node(node.right, value)
  end
end

bst = BST.new
[50, 30, 70, 20, 40, 60, 80].each { |v| bst.insert(v) }
p bst.find(70)  # => true
p bst.find(99)  # => false

# ============================================================
# 7. HEAP (Priority Queue) — O(log n) push/pop
# ============================================================
class MinHeap
  def initialize
    @heap = []
  end

  def push(value)
    @heap << value
    sift_up(@heap.size - 1)
  end

  def pop
    return nil if @heap.empty?

    min = @heap[0]
    @heap[0] = @heap.pop
    sift_down(0) unless @heap.empty?
    min
  end

  def peek
    @heap[0]
  end

  private

  def sift_up(idx)
    parent = (idx - 1) / 2
    return if idx <= 0 || @heap[parent] <= @heap[idx]

    @heap[parent], @heap[idx] = @heap[idx], @heap[parent]
    sift_up(parent)
  end

  def sift_down(idx)
    left = idx * 2 + 1
    right = idx * 2 + 2
    smallest = idx

    smallest = left if left < @heap.size && @heap[left] < @heap[smallest]
    smallest = right if right < @heap.size && @heap[right] < @heap[smallest]
    return if smallest == idx

    @heap[idx], @heap[smallest] = @heap[smallest], @heap[idx]
    sift_down(smallest)
  end
end

heap = MinHeap.new
[5, 3, 8, 1, 2].each { |v| heap.push(v) }
p heap.pop  # => 1
p heap.pop  # => 2
p heap.pop  # => 3

# ============================================================
# 8. GRAPH — adjacency list, BFS traversal
# ============================================================
require 'set'

class Graph
  def initialize
    @adj = Hash.new { |h, k| h[k] = [] }
  end

  def add_edge(from, to)
    @adj[from] << to
    @adj[to] << from   # undirected
  end

  def neighbors(node)
    @adj[node] || []
  end

  def bfs(start)
    visited = Set.new
    queue = [start]
    visit_order = []

    while queue.any?
      node = queue.shift
      next if visited.include?(node)

      visited << node
      visit_order << node
      @adj[node].each { |n| queue << n unless visited.include?(n) }
    end
    visit_order
  end
end

graph = Graph.new
graph.add_edge("A", "B")
graph.add_edge("A", "C")
graph.add_edge("B", "D")
graph.add_edge("C", "E")

p graph.neighbors("A")  # => ["B", "C"]
p graph.bfs("A")        # => ["A", "B", "C", "D", "E"]
