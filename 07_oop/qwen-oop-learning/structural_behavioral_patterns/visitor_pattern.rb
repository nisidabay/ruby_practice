#!/usr/bin/env ruby

# Visitor Pattern — Separate Algorithms from Object Structure
# Core Idea: Move operations out of object classes and into separate visitor
# objects. This lets you add new operations without changing the object classes.


# =============================================================================
# 1. THE VISITOR INTERFACE
# =============================================================================
# All visitors must implement visit methods for each element type.

class Visitor
  def visit_concrete_element_a(element); end
  def visit_concrete_element_b(element); end
end


# =============================================================================
# 2. THE ELEMENT INTERFACE
# =============================================================================
# Elements must accept visitors and call the appropriate visit method.

class Element
  def accept(visitor)
    raise NotImplementedError, "Subclasses must implement accept()"
  end
end


# =============================================================================
# 3. CONCRETE ELEMENTS
# =============================================================================
# Each element type knows how to accept a visitor.

class ConcreteElementA < Element
  def initialize(value)
    @value = value
  end

  def accept(visitor)
    visitor.visit_concrete_element_a(self)
  end

  attr_reader :value

  def operation_a
    "A:#{@value}"
  end
end

class ConcreteElementB < Element
  def initialize(value)
    @value = value
  end

  def accept(visitor)
    visitor.visit_concrete_element_b(self)
  end

  attr_reader :value

  def operation_b
    "B:#{@value}"
  end
end


# =============================================================================
# 4. THE OBJECT STRUCTURE
# =============================================================================
# Collection of elements that can be visited.

class ObjectStructure
  def initialize
    @elements = []
  end

  def add_element(element)
    @elements << element
  end

  def accept(visitor)
    @elements.each { |element| element.accept(visitor) }
  end

  def elements
    @elements
  end
end


# =============================================================================
# 5. CONCRETE VISITORS
# =============================================================================
# Each visitor implements a different operation across all element types.

class ConcreteVisitorA < Visitor
  def initialize
    @result = []
  end

  def visit_concrete_element_a(element)
    puts "  [VisitorA visiting ElementA: #{element.operation_a}]"
    @result << element.operation_a.upcase
  end

  def visit_concrete_element_b(element)
    puts "  [VisitorA visiting ElementB: #{element.operation_b}]"
    @result << element.operation_b.reverse
  end

  attr_reader :result
end

class ConcreteVisitorB < Visitor
  def initialize
    @sum_a = 0
    @sum_b = 0
  end

  def visit_concrete_element_a(element)
    value = element.value.to_i
    @sum_a += value
    puts "  [VisitorB summing ElementA: +#{value}]"
  end

  def visit_concrete_element_b(element)
    value = element.value.to_i
    @sum_b += value
    puts "  [VisitorB summing ElementB: +#{value}]"
  end

  def total
    @sum_a + @sum_b
  end

  def breakdown
    "A: #{@sum_a}, B: #{@sum_b}"
  end
end

class JSONExportVisitor < Visitor
  def initialize
    @data = []
  end

  def visit_concrete_element_a(element)
    @data << { type: "A", value: element.value }
    puts "  [JSONVisitor exported ElementA]"
  end

  def visit_concrete_element_b(element)
    @data << { type: "B", value: element.value }
    puts "  [JSONVisitor exported ElementB]"
  end

  def to_json
    require "json"
    @data.to_json
  end
end


# =============================================================================
# 6. REAL-WORLD EXAMPLE: Document Shapes
# =============================================================================

class Shape
  def accept(visitor)
    raise NotImplementedError
  end
end

class Circle < Shape
  def initialize(radius)
    @radius = radius
  end

  def accept(visitor)
    visitor.visit_circle(self)
  end

  attr_reader :radius

  def area
    Math::PI * @radius * @radius
  end
end

class Rectangle < Shape
  def initialize(width, height)
    @width = width
    @height = height
  end

  def accept(visitor)
    visitor.visit_rectangle(self)
  end

  attr_reader :width, :height

  def area
    @width * @height
  end
end

class Triangle < Shape
  def initialize(base, height)
    @base = base
    @height = height
  end

  def accept(visitor)
    visitor.visit_triangle(self)
  end

  attr_reader :base, :height

  def area
    (@base * @height) / 2.0
  end
end

class Drawing
  def initialize
    @shapes = []
  end

  def add_shape(shape)
    @shapes << shape
  end

  def accept(visitor)
    @shapes.each { |shape| shape.accept(visitor) }
  end
end

# Visitor 1: Calculate total area
class AreaCalculatorVisitor
  def initialize
    @total = 0
  end

  def visit_circle(circle)
    @total += circle.area
    puts "  Circle area: #{circle.area.round(2)}"
  end

  def visit_rectangle(rect)
    @total += rect.area
    puts "  Rectangle area: #{rect.area}"
  end

  def visit_triangle(tri)
    @total += tri.area
    puts "  Triangle area: #{tri.area}"
  end

  attr_reader :total
end

# Visitor 2: Draw shapes as SVG
class SVGRendererVisitor
  def initialize
    @svg_parts = ['<svg xmlns="http://www.w3.org/2000/svg">']
  end

  def visit_circle(circle)
    r = circle.radius
    @svg_parts << "  <circle cx=\"#{r}\" cy=\"#{r}\" r=\"#{r}\" />"
    puts "  Rendered circle with radius #{r}"
  end

  def visit_rectangle(rect)
    @svg_parts << "  <rect width=\"#{rect.width}\" height=\"#{rect.height}\" />"
    puts "  Rendered rectangle #{rect.width}x#{rect.height}"
  end

  def visit_triangle(tri)
    # Simplified triangle rendering
    @svg_parts << "  <!-- Triangle base=#{tri.base}, height=#{tri.height} -->"
    puts "  Rendered triangle"
  end

  def to_svg
    @svg_parts << "</svg>"
    @svg_parts.join("\n")
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Visitor Pattern Demo ===\n\n"

# Basic example
puts "--- Basic Visitor Example ---"
structure = ObjectStructure.new
structure.add_element(ConcreteElementA.new("foo"))
structure.add_element(ConcreteElementB.new("bar"))
structure.add_element(ConcreteElementA.new("baz"))

puts "\nUsing VisitorA (transform operations):"
visitor_a = ConcreteVisitorA.new
structure.accept(visitor_a)
puts "Result: #{visitor_a.result.join(", ")}"

puts "\nUsing VisitorB (sum values):"
visitor_b = ConcreteVisitorB.new
structure.accept(visitor_b)
puts "Total: #{visitor_b.total} (#{visitor_b.breakdown})"

puts "\nUsing JSONExportVisitor:"
json_visitor = JSONExportVisitor.new
structure.accept(json_visitor)
puts "JSON: #{json_visitor.to_json}"

# Real-world example: shapes
puts "\n--- Shape Drawing Example ---"
drawing = Drawing.new
drawing.add_shape(Circle.new(5))
drawing.add_shape(Rectangle.new(10, 20))
drawing.add_shape(Triangle.new(8, 12))
drawing.add_shape(Circle.new(3))

puts "\nCalculating areas:"
area_visitor = AreaCalculatorVisitor.new
drawing.accept(area_visitor)
puts "Total area: #{area_visitor.total.round(2)}"

puts "\nRendering to SVG:"
svg_visitor = SVGRendererVisitor.new
drawing.accept(svg_visitor)
puts "\n#{svg_visitor.to_svg}"

puts "\n=== Key Takeaway ==="
puts "Visitor lets you add new operations without changing element classes."
puts "Perfect for: exporters, calculators, renderers, validators."
puts "Trade-off: Adding new element types requires updating all visitors."
