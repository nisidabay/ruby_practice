#!/usr/bin/env ruby
# frozen_string_literal: true

# 04_binary_search_tree.rb — BST: O(log n) search/insert on average
#
# WITHOUT BST — linear search is O(n):
#
#   [50,30,70,20,40].include?(70)  # scans 3 elements on average, n worst case
#
# WITH BST — each comparison eliminates half the tree:

class Node
  attr_accessor :value, :left, :right
  def initialize(v); @value = v; @left = nil; @right = nil; end
end

class BST
  def initialize; @root = nil; end

  def insert(value)
    @root = insert_node(@root, value)
  end

  def find(value)
    search_node(@root, value)
  end

  private

  def insert_node(node, value)
    return Node.new(value) unless node
    value < node.value ?
      node.left = insert_node(node.left, value) :
      node.right = insert_node(node.right, value)
    node
  end

  def search_node(node, value)
    return false unless node
    return true if node.value == value
    value < node.value ?
      search_node(node.left, value) :
      search_node(node.right, value)
  end
end

bst = BST.new
[50, 30, 70, 20, 40].each { |v| bst.insert(v) }
puts bst.find(70)  # => true  (found in 2 steps: right child of 50)
puts bst.find(99)  # => false
