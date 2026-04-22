#!/usr/bin/env ruby

# Composite Pattern — Treat Individual and Composite Objects Uniformly
# Core Idea: Compose objects into tree structures to represent part-whole hierarchies.
# Composite lets clients treat individual objects and compositions of objects uniformly.


# =============================================================================
# 1. THE COMPONENT INTERFACE
# =============================================================================
# Common interface for all elements in the tree.

class Graphic
  def move(x, y); end
  def draw; end
  def add(component); end
  def remove(component); end
  def child(index); end

  attr_reader :x, :y
end


# =============================================================================
# 2. LEAF NODES
# =============================================================================
# Individual objects that have no children.

class Dot < Graphic
  def initialize(x, y)
    @x = x
    @y = y
  end

  def move(x, y)
    @x += x
    @y += y
    puts "  [Dot] Moved to (#{@x}, #{@y})"
  end

  def draw
    puts "  [Dot] Drawing at (#{@x}, #{@y})"
  end
end

class Circle < Graphic
  def initialize(x, y, radius)
    @x = x
    @y = y
    @radius = radius
  end

  def move(x, y)
    @x += x
    @y += y
    puts "  [Circle] Moved to (#{@x}, #{@y}), radius: #{@radius}"
  end

  def draw
    puts "  [Circle] Drawing at (#{@x}, #{@y}), radius: #{@radius}"
  end
end

class Rectangle < Graphic
  def initialize(x, y, width, height)
    @x = x
    @y = y
    @width = width
    @height = height
  end

  def move(x, y)
    @x += x
    @y += y
    puts "  [Rectangle] Moved to (#{@x}, #{@y}), size: #{@width}x#{@height}"
  end

  def draw
    puts "  [Rectangle] Drawing at (#{@x}, #{@y}), size: #{@width}x#{@height}"
  end
end


# =============================================================================
# 3. COMPOSITE NODE
# =============================================================================
# Container that can hold other components (leaves or composites).

class CompoundGraphic < Graphic
  def initialize
    @children = []
    @x = 0
    @y = 0
  end

  def add(component)
    @children << component
    puts "  [Compound] Added #{component.class.name}"
  end

  def remove(component)
    @children.delete(component)
    puts "  [Compound] Removed #{component.class.name}"
  end

  def child(index)
    @children[index]
  end

  def move(x, y)
    @x += x
    @y += y
    puts "  [Compound] Moving all children by (#{x}, #{y})"
    @children.each { |child| child.move(x, y) }
  end

  def draw
    puts "[CompoundGraphic] Drawing #{children_count} components:"
    @children.each { |child| child.draw }
  end

  def children_count
    @children.length
  end
end


# =============================================================================
# 4. THE CLIENT
# =============================================================================
# Works with all components through the common interface.

class ImageEditor
  def initialize
    @root = CompoundGraphic.new
  end

  def add_component(component)
    @root.add(component)
  end

  def move_all(x, y)
    puts "\n[Editor] Moving all components:"
    @root.move(x, y)
  end

  def draw_all
    puts "\n[Editor] Drawing all components:"
    @root.draw
  end

  def component_count
    @root.children_count
  end
end


# =============================================================================
# 5. REAL-WORLD EXAMPLE: File System
# =============================================================================

class FileSystemComponent
  def name; end
  def size; end
  def display(indent = 0); end
end

class FileNode < FileSystemComponent
  def initialize(name, size)
    @name = name
    @size = size
  end

  def name
    @name
  end

  def size
    @size
  end

  def display(indent = 0)
    puts "#{"  " * indent}📄 #{@name} (#{@size} bytes)"
  end
end

class Directory < FileSystemComponent
  def initialize(name)
    @name = name
    @children = []
  end

  def name
    @name
  end

  def size
    @children.sum(&:size)
  end

  def add(component)
    @children << component
  end

  def remove(component)
    @children.delete(component)
  end

  def display(indent = 0)
    puts "#{"  " * indent}📁 #{@name} (#{size} bytes)"
    @children.each { |child| child.display(indent + 1) }
  end
end


# =============================================================================
# 6. REAL-WORLD EXAMPLE: Organization Hierarchy
# =============================================================================

class Employee
  def initialize(name, title)
    @name = name
    @title = title
  end

  def add_employee(employee); end
  def remove_employee(employee); end
  def get_employees; []; end

  def display(indent = 0)
    puts "#{"  " * indent}👤 #{@name} - #{@title}"
  end

  def headcount
    1
  end
end

class Manager < Employee
  def initialize(name, title)
    super
    @subordinates = []
  end

  def add_employee(employee)
    @subordinates << employee
  end

  def remove_employee(employee)
    @subordinates.delete(employee)
  end

  def get_employees
    @subordinates
  end

  def display(indent = 0)
    puts "#{"  " * indent}👔 #{@name} - #{@title} (#{@subordinates.length} reports)"
    @subordinates.each { |emp| emp.display(indent + 1) }
  end

  def headcount
    1 + @subordinates.sum(&:headcount)
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Composite Pattern Demo ===\n\n"

# Graphics example
puts "--- Graphics Editor ---"
editor = ImageEditor.new

# Create simple shapes
dot = Dot.new(1, 2)
circle = Circle.new(3, 4, 5)
rect = Rectangle.new(6, 7, 8, 9)

# Create compound graphics (composites)
compound1 = CompoundGraphic.new
compound1.add(dot)
compound1.add(circle)

compound2 = CompoundGraphic.new
compound2.add(rect)

# Compound can contain other compounds
super_compound = CompoundGraphic.new
super_compound.add(compound1)
super_compound.add(compound2)

editor.add_component(super_compound)
editor.draw_all

editor.move_all(10, 10)
editor.draw_all

# File system example
puts "\n--- File System Tree ---"
root = Directory.new("root")

# Create files
readme = FileNode.new("README.md", 1024)
config = FileNode.new("config.yaml", 512)
main_rb = FileNode.new("main.rb", 2048)
test_rb = FileNode.new("test.rb", 1536)

# Create directories
src_dir = Directory.new("src")
test_dir = Directory.new("test")
docs_dir = Directory.new("docs")

# Build tree
src_dir.add(main_rb)
test_dir.add(test_rb)
docs_dir.add(readme)
docs_dir.add(config)

root.add(src_dir)
root.add(test_dir)
root.add(docs_dir)

root.display

puts "\nTotal size: #{root.size} bytes"

# Organization hierarchy
puts "\n--- Organization Chart ---"
ceo = Manager.new("Alice", "CEO")
cto = Manager.new("Bob", "CTO")
cfo = Manager.new("Carol", "CFO")

dev_lead = Manager.new("Dave", "Dev Lead")
dev1 = Employee.new("Eve", "Developer")
dev2 = Employee.new("Frank", "Developer")
dev3 = Employee.new("Grace", "Developer")

accountant = Employee.new("Henry", "Accountant")

# Build hierarchy
dev_lead.add_employee(dev1)
dev_lead.add_employee(dev2)
dev_lead.add_employee(dev3)

cto.add_employee(dev_lead)
cfo.add_employee(accountant)

ceo.add_employee(cto)
ceo.add_employee(cfo)

ceo.display
puts "\nTotal headcount: #{ceo.headcount}"

puts "\n=== Key Takeaway ==="
puts "Composite lets you treat individual objects and compositions uniformly."
puts "Client code doesn't need to know if it's working with a leaf or composite."
puts "Common uses: UI component trees, file systems, organization charts, ASTs."
