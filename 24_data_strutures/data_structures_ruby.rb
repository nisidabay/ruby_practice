# ============================================================================
# 8 FUNDAMENTAL DATA STRUCTURES - Ruby Implementation
# Based on: "The 8 Data Structures EVERY Programmer Uses"
# Video: https://www.youtube.com/watch?v=9ifwAPFxpu0
# ============================================================================

# ============================================================================
# 1. ARRAY
# ============================================================================
# Analogy: Shopping mall parking lot - each space has a number painted (0, 1, 2...)
# Advantage: Instant access by index O(1)
# Disadvantage: Inserting in the middle is slow O(n) - must move all elements
# Ideal use: When you read more than you modify

puts "=" * 80
puts "1. ARRAY"
puts "=" * 80

# Array creation
cars = ["Toyota", "Mazda", "Ford", "BMW", "Audi"]
puts "Original array: #{cars.inspect}"

# Instant access by index - O(1)
puts "Access at index 2: #{cars[2]}"  # Ford - instant!

# Add to end - O(1) amortized
cars << "Tesla"
puts "After adding Tesla to end: #{cars.inspect}"

# Insert in middle - O(n) - slow! Moves all following elements
cars.insert(1, "Honda")
puts "After inserting Honda at position 1: #{cars.inspect}"
puts "   ^ This required moving Mazda, Ford, BMW, Audi, Tesla one position"

# Real use cases:
# - Video game scores
# - Image pixels
# - Product catalogs
# - Data table rows


# ============================================================================
# 2. LINKED LIST
# ============================================================================
# Analogy: Treasure hunt - each clue tells you where the next one is
# Advantage: Insert/delete is fast O(1) - only change references
# Disadvantage: Index access is slow O(n) - must traverse from start
# Ideal use: When you insert/delete constantly, without random access

puts "\n" + "=" * 80
puts "2. LINKED LIST"
puts "=" * 80

class Node
  attr_accessor :value, :next
  
  def initialize(value)
    @value = value
    @next = nil  # Reference to next node (initially null)
  end
end

class LinkedList
  attr_accessor :head
  
  def initialize
    @head = nil
  end
  
  # Add to beginning - O(1) - regardless of list size!
  def add_to_beginning(value)
    new_node = Node.new(value)
    new_node.next = @head  # New node points to current head
    @head = new_node       # Head is now the new node
  end
  
  # Show all elements
  def display
    elements = []
    current = @head
    while current
      elements << current.value
      current = current.next
    end
    elements.join(" -> ")
  end
  
  # Add to end - O(n)
  def add_to_end(value)
    new_node = Node.new(value)
    
    if @head.nil?
      @head = new_node
      return
    end
    
    current = @head
    while current.next
      current = current.next
    end
    current.next = new_node
  end
end

# Example usage
list = LinkedList.new
list.add_to_beginning("Ford")
list.add_to_beginning("Mazda")
list.add_to_beginning("Toyota")

puts "List after adding 3 cars to beginning: #{list.display}"
puts "   ^ Each beginning insertion is O(1) - only change references"

list.add_to_end("Audi")
puts "List after adding Audi to end: #{list.display}"

# Real use cases:
# - Social media feeds (new posts on top)
# - Dynamic music playlists
# - Base for stacks and queues
# - Browser history


# ============================================================================
# 3. STACK - LIFO
# ============================================================================
# Analogy: Stack of plates - last in is first out (LIFO)
# Operations: push (add on top), pop (remove from top)
# Ideal use: Control Z, back button, call stack, validate parentheses

puts "\n" + "=" * 80
puts "3. STACK - LIFO: Last In, First Out"
puts "=" * 80

class Stack
  def initialize
    @elements = []
  end
  
  # Push - add on top - O(1)
  def push(value)
    @elements << value
  end
  
  # Pop - remove from top - O(1)
  def pop
    @elements.pop
  end
  
  # View top element without removing
  def top
    @elements.last
  end
  
  def empty?
    @elements.empty?
  end
  
  def size
    @elements.size
  end
  
  def display
    @elements.inspect
  end
end

# Example: Control Z system
stack = Stack.new

puts "\nSimulating actions in a text editor:"
stack.push("Write 'hello'")
puts "  Push: Write 'hello' -> Stack: #{stack.display}"

stack.push("Write 'world'")
puts "  Push: Write 'world' -> Stack: #{stack.display}"

stack.push("Apply bold")
puts "  Push: Apply bold -> Stack: #{stack.display}"

puts "\nPressing Control Z (pop):"
puts "  Pop: #{stack.pop} <- Last action undone"
puts "  Remaining stack: #{stack.display}"

puts "  Pop: #{stack.pop} <- Second action undone"
puts "  Remaining stack: #{stack.display}"

# Real use cases:
# - Control Z (undo)
# - Browser back button
# - Call stack (function calls)
# - Validate parentheses in compilers
# - "Stack Overflow" error = stack full of nested calls


# ============================================================================
# 4. QUEUE - FIFO
# ============================================================================
# Analogy: Bank line - first to arrive is first served (FIFO)
# Operations: enqueue (add to end), dequeue (remove from front)
# Ideal use: Print queues, pending messages, task processing

puts "\n" + "=" * 80
puts "4. QUEUE - FIFO: First In, First Out"
puts "=" * 80

class Queue
  def initialize
    @elements = []
  end
  
  # Enqueue - add to end - O(1)
  def enqueue(value)
    @elements << value
  end
  
  # Dequeue - remove from front - O(n) in array, O(1) with proper implementation
  def dequeue
    @elements.shift
  end
  
  # View next without removing
  def front
    @elements.first
  end
  
  def empty?
    @elements.empty?
  end
  
  def size
    @elements.size
  end
  
  def display
    @elements.inspect
  end
end

# Example: Customer line at bank
queue = Queue.new

puts "\nCustomers arriving at bank:"
queue.enqueue("Ana - arrived first")
puts "  Enqueue: Ana -> Queue: #{queue.display}"

queue.enqueue("Luis - arrived second")
puts "  Enqueue: Luis -> Queue: #{queue.display}"

queue.enqueue("Maria - arrived third")
puts "  Enqueue: Maria -> Queue: #{queue.display}"

puts "\nServing customers (respecting arrival order):"
puts "  Dequeue: #{queue.dequeue} <- Served first"
puts "  Remaining queue: #{queue.display}"

puts "  Dequeue: #{queue.dequeue} <- Served second"
puts "  Remaining queue: #{queue.display}"

# Real use cases:
# - Print queue
# - WhatsApp messages pending send
# - Web servers processing requests
# - RabbitMQ, Kafka (messaging systems)
# - Background task processing


# ============================================================================
# 5. HASH TABLE ⭐ THE MOST IMPORTANT
# ============================================================================
# Analogy: Paper dictionary - for "apple" go directly to M section, don't start at page 1
# Advantage: Search, insert, delete in O(1) average
# Ideal use: Fast lookups, cache, counting elements, detecting duplicates
# THE MOST IMPORTANT! Most used in the real world

puts "\n" + "=" * 80
puts "5. HASH TABLE (Dictionary / Map)"
puts "=" * 80

# In Ruby, Hashes are native and optimized

# Example 1: Search users by email - O(1)
users = {
  "carlos@email.com" => { name: "Carlos", age: 30, city: "Madrid" },
  "ana@email.com" => { name: "Ana", age: 25, city: "Barcelona" }
}

puts "\nUser lookup by email (O(1) - instant):"
puts "  Email: ana@email.com"
puts "  Data: #{users["ana@email.com"].inspect}"

# Add new user - O(1)
users["maria@email.com"] = { name: "Maria", age: 28, city: "Valencia" }
puts "\nAfter adding Maria: #{users.keys.inspect}"

# Example 2: Count words in text - super common pattern
text = "hello world hello ruby hello world ruby"
counter = Hash.new(0)  # Default value is 0

text.split(" ").each do |word|
  counter[word] += 1
end

puts "\nWord counter:"
counter.each { |word, count| puts "  #{word}: #{count}" }

# Real use cases:
# - Browser cache
# - User sessions
# - Count words/frequencies
# - Detect duplicates
# - Database indexes
# - Environment variables
# - Technical interviews!


# ============================================================================
# 6. BINARY SEARCH TREE
# ============================================================================
# Analogy: Guess number 1-100 - ask 50, discard half each time
# Advantage: Search in O(log n) - 20 steps for 1 million elements
# Rule: Smaller to left, larger to right
# Ideal use: Frequent searches, file systems, database indexes

puts "\n" + "=" * 80
puts "6. BINARY SEARCH TREE"
puts "=" * 80

class TreeNode
  attr_accessor :value, :left, :right
  
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  attr_accessor :root
  
  def initialize
    @root = nil
  end
  
  # Insert - O(log n) in balanced tree
  def insert(value)
    @root = insert_recursive(@root, value)
  end
  
  private def insert_recursive(node, value)
    return TreeNode.new(value) if node.nil?
    
    if value < node.value
      node.left = insert_recursive(node.left, value)
    elsif value > node.value
      node.right = insert_recursive(node.right, value)
    end
    
    node
  end
  
  # Search - O(log n) - discards half tree each step
  def search(value)
    search_recursive(@root, value)
  end
  
  private def search_recursive(node, value)
    return nil if node.nil?
    return node if node.value == value
    
    if value < node.value
      search_recursive(node.left, value)
    else
      search_recursive(node.right, value)
    end
  end
  
  # In-order traversal (left, root, right) - returns sorted
  def in_order
    results = []
    in_order_recursive(@root, results)
    results
  end
  
  private def in_order_recursive(node, results)
    return if node.nil?
    
    in_order_recursive(node.left, results)
    results << node.value
    in_order_recursive(node.right, results)
  end
end

# Example usage
tree = BinarySearchTree.new

puts "\nInserting numbers into tree:"
[50, 30, 70, 20, 40, 60, 80].each do |num|
  tree.insert(num)
  puts "  Inserted: #{num}"
end

puts "\nIn-order traversal (returns sorted): #{tree.in_order.inspect}"

puts "\nSearches:"
puts "  Search 40: #{tree.search(40) ? 'Found' : 'Not found'}"
puts "  Search 100: #{tree.search(100) ? 'Found' : 'Not found'}"

# Real use cases:
# - File systems (folders inside folders)
# - Web page DOM (nested HTML)
# - Database indexes (B-Trees)
# - Decision trees in Machine Learning
# - AlphaGo (Monte Carlo Tree Search)


# ============================================================================
# 7. HEAP - Priority Queue
# ============================================================================
# Analogy: Emergency room - treat by severity, not arrival order
# Property: Highest priority element always at root
# Ideal use: Priority queues, Dijkstra, Huffman algorithm, top N elements

puts "\n" + "=" * 80
puts "7. HEAP - Priority Queue"
puts "=" * 80

class Heap
  def initialize
    @elements = []
  end
  
  # Insert - O(log n)
  def insert(value, priority)
    @elements << { value: value, priority: priority }
    @elements.sort_by! { |elem| elem[:priority] }  # Min-heap: lower priority = more urgent
  end
  
  # Extract highest priority - O(log n)
  def extract
    @elements.shift
  end
  
  def empty?
    @elements.empty?
  end
  
  def size
    @elements.size
  end
end

# Example: Emergency room
heap = Heap.new

puts "\nPatients arriving at ER (out of order):"
heap.insert("Headache", 3)
puts "  Arrives: Headache (priority 3)"

heap.insert("Heart attack", 1)  # 1 = most urgent
puts "  Arrives: Heart attack (priority 1) - Maximum urgency!"

heap.insert("Fracture", 2)
puts "  Arrives: Fracture (priority 2)"

heap.insert("Cold", 5)  # 5 = least urgent
puts "  Arrives: Cold (priority 5)"

puts "\nTreating by urgency order (not arrival order):"
while !heap.empty?
  patient = heap.extract
  puts "  Treating: #{patient[:value]} (priority #{patient[:priority]})"
end

# Real use cases:
# - Google Maps / Waze (Dijkstra algorithm for shortest path)
# - Operating system (which process to run first)
# - Top 10 rankings (video games, popular news)
# - Email servers by priority
# - Huffman algorithm (ZIP, JPG compression)


# ============================================================================
# 8. GRAPH - Adjacency List
# ============================================================================
# Analogy: Social network - people are nodes, friendships are connections
# Types: Directed (one-way arrows) or Undirected (mutual connection)
# Ideal use: Social networks, maps, recommendation systems, PageRank

puts "\n" + "=" * 80
puts "8. GRAPH - Adjacency List"
puts "=" * 80

class Graph
  def initialize
    @adjacency = Hash.new { |h, k| h[k] = [] }
  end
  
  # Add edge (connection) - O(1)
  def add_edge(node1, node2)
    @adjacency[node1] << node2
    @adjacency[node2] << node1  # For undirected graph
  end
  
  # Get neighbors of a node
  def neighbors(node)
    @adjacency[node]
  end
  
  # Display entire graph
  def display
    @adjacency.each do |node, neighbors|
      puts "  #{node}: #{neighbors.join(', ')}"
    end
  end
  
  # BFS - Breadth-First Search
  # Explores layer by layer - finds shortest path in unweighted graphs
  def bfs(start_node)
    visited = []
    queue = [start_node]
    
    while !queue.empty?
      node = queue.shift
      
      next if visited.include?(node)
      visited << node
      
      # Add unvisited neighbors to queue
      @adjacency[node].each do |neighbor|
        queue << neighbor unless visited.include?(neighbor)
      end
    end
    
    visited
  end
end

# Example: Social network
social_network = Graph.new

puts "\nCreating social network:"
social_network.add_edge("Carlos", "Ana")
social_network.add_edge("Carlos", "Luis")
social_network.add_edge("Ana", "Maria")
social_network.add_edge("Ana", "Sofia")
social_network.add_edge("Luis", "Pedro")
social_network.add_edge("Maria", "Pedro")

puts "\nAdjacency list:"
social_network.display

puts "\nBFS from Carlos (explores layer by layer):"
traversal = social_network.bfs("Carlos")
puts "  Visit order: #{traversal.inspect}"
puts "  ^ First direct friends, then friends of friends"

# Real use cases:
# - Social networks (Facebook, Instagram, LinkedIn)
# - Google Maps / Waze / Uber (routes)
# - Recommendation systems (Netflix, Spotify, TikTok)
# - Internet (web pages + hyperlinks)
# - Google PageRank and Knowledge Graph
# - Friend suggestions ("People you may know")


# ============================================================================
# COMPARATIVE SUMMARY
# ============================================================================

puts "\n" + "=" * 80
puts "DATA STRUCTURES COMPARATIVE SUMMARY"
puts "=" * 80

puts <<~SUMMARY

  Structure       | Access  | Insert    | Search    | Main Use
  ----------------|---------|-----------|-----------|------------------
  Array           | O(1)    | O(n)      | O(n)      | Frequent reading
  Linked List     | O(n)    | O(1)*     | O(n)      | Frequent insertion
  Stack           | O(n)    | O(1)      | O(n)      | LIFO (Control Z)
  Queue           | O(n)    | O(1)      | O(n)      | FIFO (Queues)
  Hash Table      | N/A     | O(1)      | O(1)      | Fast lookups ⭐
  Binary Search T | O(log n)| O(log n)  | O(log n)  | Sorted searches
  Heap            | O(n)    | O(log n)  | O(1)**    | Priorities
  Graph           | O(n)    | O(1)      | O(V+E)    | Relationships

  * O(1) if at beginning/with known references
  ** Only the highest priority element

  RECOMMENDATION: If you only learn one, make it Hash Table.
  It's the most used in the real world and in technical interviews.

SUMMARY

puts "=" * 80
puts "You completed the tour of the 8 fundamental data structures!"
puts "=" * 80

