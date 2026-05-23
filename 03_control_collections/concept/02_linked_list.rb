#!/usr/bin/env ruby
# frozen_string_literal: true

# 02_linked_list.rb — Linked list: O(1) insert at head, O(n) access
#
# WITHOUT a linked list — Array insert at position 0 is O(n):
#
#   list.unshift("new")  # shifts every existing element right
#
# WITH linked list — pointer swap, O(1):

class Node
  attr_accessor :value, :next
  def initialize(value); @value = value; @next = nil; end
end

class LinkedList
  def initialize; @head = nil; end

  def prepend(value)           # O(1) — point new node to old head
    node = Node.new(value)
    node.next = @head
    @head = node
  end

  def to_a
    result = []
    cur = @head
    while cur
      result << cur.value
      cur = cur.next
    end
    result
  end
end

list = LinkedList.new
list.prepend("Ford")
list.prepend("Mazda")
list.prepend("Toyota")
p list.to_a  # => ["Toyota", "Mazda", "Ford"]
