#!/usr/bin/env ruby

# Flyweight Pattern — Minimize Memory with Shared State
# Core Idea: Use sharing to support large numbers of fine-grained objects efficiently.
# Flyweight shares common state between multiple objects instead of storing it in each.


# =============================================================================
# 1. THE FLYWEIGHT INTERFACE
# =============================================================================

class TreeType
  def draw(x, y, age); end

  attr_reader :name, :color, :texture
end


# =============================================================================
# 2. CONCRETE FLYWEIGHT
# =============================================================================
# Stores intrinsic (shared) state.

class ConcreteTreeType < TreeType
  def initialize(name, color, texture)
    @name = name
    @color = color
    @texture = texture
    puts "  [TreeType] Created '#{@name}' (#{@color}, #{@texture})"
  end

  def draw(x, y, age)
    # Extrinsic (unique) state passed as parameters
    puts "  [Tree] Drawing #{@name} at (#{x}, #{y}), age: #{age}"
  end

  attr_reader :name, :color, :texture
end


# =============================================================================
# 3. THE FLYWEIGHT FACTORY
# =============================================================================
# Manages shared flyweights and ensures uniqueness.

class TreeTypeFactory
  def initialize
    @tree_types = {}
  end

  def get_tree_type(name, color, texture)
    key = "#{name}-#{color}-#{texture}"
    
    if @tree_types.key?(key)
      puts "  [Factory] Reusing existing '#{name}' type"
      @tree_types[key]
    else
      puts "  [Factory] Creating new '#{name}' type"
      @tree_types[key] = ConcreteTreeType.new(name, color, texture)
    end
  end

  def count
    @tree_types.length
  end

  def list_types
    @tree_types.keys
  end
end


# =============================================================================
# 4. THE CONTEXT
# =============================================================================
# Stores extrinsic (unique) state and references shared flyweight.

class Tree
  def initialize(x, y, age, tree_type)
    @x = x
    @y = y
    @age = age
    @tree_type = tree_type
  end

  def draw
    @tree_type.draw(@x, @y, @age)
  end
end


# =============================================================================
# 5. THE CLIENT
# =============================================================================

class Forest
  def initialize
    @trees = []
    @factory = TreeTypeFactory.new
  end

  def plant_tree(x, y, age, name, color, texture)
    type = @factory.get_tree_type(name, color, texture)
    tree = Tree.new(x, y, age, type)
    @trees << tree
  end

  def draw_all
    puts "\n[Forest] Drawing #{@trees.length} trees:"
    @trees.each(&:draw)
  end

  def tree_count
    @trees.length
  end

  def type_count
    @factory.count
  end

  def memory_report
    puts "\n[Forest] Memory Report:"
    puts "  Total trees: #{@trees.length}"
    puts "  Unique types: #{@factory.count}"
    puts "  Memory saved: #{@trees.length - @factory.count} tree objects"
  end

  def trees
    @trees
  end
end


# =============================================================================
# 6. REAL-WORLD EXAMPLE: Text Formatting
# =============================================================================

class CharacterFormat
  def initialize(font, size, color, style)
    @font = font
    @size = size
    @color = color
    @style = style
  end

  def to_s
    "#{@font}-#{@size}-#{@color}-#{@style}"
  end
end

class CharacterFormatFactory
  def initialize
    @formats = {}
  end

  def get_format(font, size, color, style)
    key = "#{font}-#{size}-#{color}-#{style}"
    @formats[key] ||= CharacterFormat.new(font, size, color, style)
  end

  def count
    @formats.length
  end
end

class FormattedCharacter
  def initialize(char, x, y, format)
    @char = char
    @x = x
    @y = y
    @format = format
  end

  def render
    # In real implementation, would render at position
  end
end

class Document
  def initialize
    @characters = []
    @factory = CharacterFormatFactory.new
  end

  def add_char(char, x, y, font, size, color, style)
    format = @factory.get_format(font, size, color, style)
    @characters << FormattedCharacter.new(char, x, y, format)
  end

  def render
    puts "[Document] Rendering #{@characters.length} characters"
    puts "  Using #{@factory.count} unique formats"
  end
end


# =============================================================================
# 7. REAL-WORLD EXAMPLE: Game Bullets
# =============================================================================

class BulletType
  def initialize(name, damage, speed, sprite)
    @name = name
    @damage = damage
    @speed = speed
    @sprite = sprite
  end

  attr_reader :name, :damage, :speed
end

class BulletTypeFactory
  def initialize
    @types = {}
  end

  def get_type(name, damage, speed, sprite)
    key = name
    @types[key] ||= BulletType.new(name, damage, speed, sprite)
  end

  def count
    @types.length
  end
end

class Bullet
  def initialize(x, y, direction, type)
    @x = x
    @y = y
    @direction = direction
    @type = type
  end

  def update
    # Move bullet based on direction and type.speed
  end

  def damage
    @type.damage
  end
end

class BulletManager
  def initialize
    @bullets = []
    @factory = BulletTypeFactory.new
  end

  def fire(x, y, direction, type_name, damage, speed)
    type = @factory.get_type(type_name, damage, speed, "#{type_name}.png")
    @bullets << Bullet.new(x, y, direction, type)
  end

  def update_all
    @bullets.each(&:update)
  end

  def active_bullets
    @bullets.length
  end

  def type_count
    @factory.count
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Flyweight Pattern Demo ===\n\n"

# Forest example
puts "--- Forest with Shared Tree Types ---"
forest = Forest.new

# Plant 1000 trees with only 3 types
puts "\nPlanting 1000 trees (only 3 unique types):"
1000.times do |i|
  x = rand(1000)
  y = rand(1000)
  age = rand(100)
  
  # Only 3 types, but 1000 trees
  type = case i % 3
         when 0 then ["Oak", "green", "rough"]
         when 1 then ["Pine", "dark-green", "smooth"]
         else ["Maple", "red", "textured"]
         end
  
  forest.plant_tree(x, y, age, *type)
end

forest.memory_report

# Draw a few trees
puts "\nDrawing sample trees:"
5.times { |i| forest.trees[i].draw }

# Text document example
puts "\n--- Text Document with Shared Formats ---"
doc = Document.new

# Add 1000 characters with shared formats
text = "The quick brown fox jumps over the lazy dog. " * 25
text.each_char.with_index do |char, i|
  # Cycle through a few formats
  font = ["Arial", "Times", "Courier"][i % 3]
  size = [12, 14, 16][i % 3]
  color = ["black", "blue", "red"][i % 3]
  style = ["normal", "bold", "italic"][i % 3]
  
  doc.add_char(char, i % 80, i / 80, font, size, color, style)
end

doc.render
puts "  Memory saved: #{text.length - doc.instance_variable_get(:@factory).count} format objects"

# Game bullets example
puts "\n--- Game Bullet System ---"
bullet_mgr = BulletManager.new

# Fire 1000 bullets with only 5 types
puts "\nFiring 1000 bullets (only 5 unique types):"
1000.times do |i|
  type = case i % 5
         when 0 then ["Pistol", 10, 5]
         when 1 then ["Rifle", 25, 10]
         when 2 then ["Shotgun", 5, 8]
         when 3 then ["Sniper", 100, 15]
         else ["Laser", 15, 20]
         end
  
  bullet_mgr.fire(rand(800), rand(600), rand(360), *type)
end

puts "[BulletManager] Active bullets: #{bullet_mgr.active_bullets}"
puts "[BulletManager] Unique types: #{bullet_mgr.type_count}"
puts "[BulletManager] Objects saved: #{bullet_mgr.active_bullets - bullet_mgr.type_count}"

puts "\n=== Key Takeaway ==="
puts "Flyweight shares intrinsic state between objects to save memory."
puts "Use when: many similar objects, most state can be made extrinsic."
puts "Common uses: Text editors, games, CAD systems, particle systems."
