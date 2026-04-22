#!/usr/bin/env ruby

# Prototype Pattern — Create Objects by Cloning
# Core Idea: Specify the kinds of objects to create using a prototypical instance,
# and create new objects by copying this prototype.


# =============================================================================
# 1. THE PROTOTYPE INTERFACE
# =============================================================================

class Prototype
  def clone
    raise NotImplementedError, "Subclasses must implement clone()"
  end
end


# =============================================================================
# 2. CONCRETE PROTOTYPES
# =============================================================================

class Enemy < Prototype
  attr_accessor :name, :health, :damage, :speed, :position

  def initialize(name, health, damage, speed)
    @name = name
    @health = health
    @damage = damage
    @speed = speed
    @position = { x: 0, y: 0 }
  end

  def clone
    # Deep copy to avoid shared references
    cloned = self.class.new(@name, @health, @damage, @speed)
    cloned.position = @position.dup
    cloned
  end

  def to_s
    "#{@name} (HP:#{@health}, DMG:#{@damage}, SPD:#{@speed}) at #{@position}"
  end

  def move_to(x, y)
    @position = { x: x, y: y }
  end
end

class Weapon < Prototype
  attr_accessor :name, :damage, :range, :fire_rate, :enchantments

  def initialize(name, damage, range, fire_rate)
    @name = name
    @damage = damage
    @range = range
    @fire_rate = fire_rate
    @enchantments = []
  end

  def clone
    cloned = self.class.new(@name, @damage, @range, @fire_rate)
    cloned.enchantments = @enchantments.dup
    cloned
  end

  def add_enchantment(name)
    @enchantments << name
  end

  def to_s
    "#{@name} (DMG:#{@damage}, RNG:#{@range}, FPS:#{@fire_rate})#{@enchantments.any? ? " [#{@enchantments.join(", ")}]" : ""}"
  end
end


# =============================================================================
# 3. PROTOTYPE REGISTRY
# =============================================================================

class PrototypeRegistry
  def initialize
    @prototypes = {}
  end

  def register(name, prototype)
    @prototypes[name] = prototype
    puts "  [Registry] Registered prototype: #{name}"
  end

  def create(name)
    return nil unless @prototypes.key?(name)

    puts "  [Registry] Creating from prototype: #{name}"
    @prototypes[name].clone
  end

  def unregister(name)
    @prototypes.delete(name)
    puts "  [Registry] Unregistered: #{name}"
  end

  def list
    @prototypes.keys
  end
end


# =============================================================================
# 4. DEEP VS SHALLOW CLONE
# =============================================================================

class ShallowClone
  attr_accessor :data, :nested

  def initialize(data)
    @data = data
    @nested = { value: 100 }
  end

  def clone
    # Shallow copy - nested objects are shared
    self.class.new(@data).tap do |cloned|
      cloned.nested = @nested  # Same reference!
    end
  end
end

class DeepClone
  attr_accessor :data, :nested

  def initialize(data)
    @data = data
    @nested = { value: 100 }
  end

  def clone
    # Deep copy - nested objects are duplicated
    self.class.new(@data).tap do |cloned|
      cloned.nested = Marshal.load(Marshal.dump(@nested))
    end
  end
end


# =============================================================================
# 5. RUBY'S BUILT-IN CLONING
# =============================================================================

class RubyClone
  attr_accessor :name, :items

  def initialize(name)
    @name = name
    @items = [1, 2, 3]
  end

  # Using Ruby's built-in clone (shallow)
  def shallow_clone
    clone
  end

  # Using Ruby's built-in dup (shallow, doesn't copy frozen state)
  def dup_clone
    dup
  end

  # Deep clone using Marshal
  def deep_clone
    Marshal.load(Marshal.dump(self))
  end
end


# =============================================================================
# 6. REAL-WORLD EXAMPLE: Document Templates
# =============================================================================

class DocumentTemplate
  attr_accessor :title, :content, :formatting, :metadata

  def initialize(title, content)
    @title = title
    @content = content
    @formatting = { font: "Arial", size: 12 }
    @metadata = { author: "Unknown", created: Time.now }
  end

  def clone
    # Deep clone for document
    cloned = self.class.new(@title, @content.dup)
    cloned.formatting = @formatting.dup
    cloned.metadata = @metadata.dup
    cloned.metadata[:created] = Time.now  # New timestamp
    cloned
  end

  def fill_template(data)
    @content = @content.gsub(/{(\w+)}/) { |match| data[$1.to_sym] || match }
  end

  def to_s
    "#{@title}\n#{"=" * 40}\n#{@content}"
  end
end


# =============================================================================
# 7. REAL-WORLD EXAMPLE: Game Level Prototypes
# =============================================================================

class Level
  attr_accessor :name, :difficulty, :enemies, :loot, :layout

  def initialize(name, difficulty)
    @name = name
    @difficulty = difficulty
    @enemies = []
    @loot = []
    @layout = []
  end

  def clone
    cloned = self.class.new(@name, @difficulty)
    cloned.enemies = @enemies.map(&:clone)
    cloned.loot = @loot.map(&:clone)
    cloned.layout = @layout.dup
    cloned
  end

  def add_enemy(enemy)
    @enemies << enemy
  end

  def add_loot(item)
    @loot << item
  end

  def set_layout(layout_data)
    @layout = layout_data
  end

  def to_s
    "#{@name} (Difficulty: #{@difficulty}) - #{@enemies.length} enemies, #{@loot.length} items"
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Prototype Pattern Demo ===\n\n"

# Enemy spawning example
puts "--- Enemy Spawning System ---"

# Create prototypes
goblin_proto = Enemy.new("Goblin", 50, 10, 5)
orc_proto = Enemy.new("Orc", 100, 20, 3)
dragon_proto = Enemy.new("Dragon", 500, 50, 8)

# Register in registry
registry = PrototypeRegistry.new
registry.register("goblin", goblin_proto)
registry.register("orc", orc_proto)
registry.register("dragon", dragon_proto)

# Spawn enemies by cloning
puts "\n[Game] Spawning enemies:"
enemy1 = registry.create("goblin")
enemy1.move_to(10, 20)
puts "Spawned: #{enemy1}"

enemy2 = registry.create("goblin")
enemy2.move_to(15, 25)
puts "Spawned: #{enemy2}"

enemy3 = registry.create("orc")
enemy3.move_to(30, 40)
puts "Spawned: #{enemy3}"

enemy4 = registry.create("dragon")
enemy4.move_to(100, 100)
puts "Spawned: #{enemy4}"

# Weapon example with enchantments
puts "\n--- Weapon System ---"
sword_proto = Weapon.new("Iron Sword", 25, 2, 1.0)
sword_proto.add_enchantment("Sharpness")

# Create variants
warrior_sword = sword_proto.clone
warrior_sword.add_enchantment("Fire")
puts "Warrior Sword: #{warrior_sword}"

mage_sword = sword_proto.clone
mage_sword.add_enchantment("Lightning")
mage_sword.damage = 15  # Less physical damage
puts "Mage Sword: #{mage_sword}"

# Deep vs Shallow clone
puts "\n--- Deep vs Shallow Clone ---"
shallow1 = ShallowClone.new("original")
shallow2 = shallow1.clone
shallow2.nested[:value] = 999

puts "Shallow clone:"
puts "  Original nested: #{shallow1.nested[:value]}"  # 999 - shared!
puts "  Clone nested: #{shallow2.nested[:value]}"     # 999

deep1 = DeepClone.new("original")
deep2 = deep1.clone
deep2.nested[:value] = 999

puts "\nDeep clone:"
puts "  Original nested: #{deep1.nested[:value]}"  # 100 - independent!
puts "  Clone nested: #{deep2.nested[:value]}"     # 999

# Ruby's built-in cloning
puts "\n--- Ruby Built-in Cloning ---"
original = RubyClone.new("original")
original.items << 4

shallow = original.shallow_clone
shallow.items << 5

deep = original.deep_clone
deep.items << 6

puts "Original items: #{original.items}"  # [1, 2, 3, 4, 5] - shallow share
puts "Shallow clone items: #{shallow.items}"  # [1, 2, 3, 4, 5]
puts "Deep clone items: #{deep.items}"  # [1, 2, 3, 4, 6] - independent

# Document templates
puts "\n--- Document Templates ---"
invoice_template = DocumentTemplate.new(
  "Invoice",
  "Invoice #{'{number}'}\nDate: {date}\nCustomer: {customer}\nAmount: ${amount}"
)

# Create multiple invoices from template
invoice1 = invoice_template.clone
invoice1.fill_template(number: "INV-001", date: "2024-01-15", customer: "Alice", amount: "100")
puts "\n#{invoice1}"

invoice2 = invoice_template.clone
invoice2.fill_template(number: "INV-002", date: "2024-01-16", customer: "Bob", amount: "250")
puts "\n#{invoice2}"

# Game levels
puts "\n--- Game Level Prototypes ---"
# Create base level prototype
tutorial_level = Level.new("Tutorial", 1)
tutorial_level.add_enemy(Enemy.new("Slime", 20, 5, 2))
tutorial_level.add_enemy(Enemy.new("Rat", 15, 3, 4))
tutorial_level.add_loot(Weapon.new("Wooden Sword", 10, 1, 0.8))
tutorial_level.set_layout([0, 0, 1, 0, 0])

# Create variations
easy_level = tutorial_level.clone
easy_level.name = "Easy Dungeon"
easy_level.difficulty = 2
easy_level.enemies << Enemy.new("Goblin", 50, 10, 5)
puts "Created: #{easy_level}"

hard_level = tutorial_level.clone
hard_level.name = "Hard Dungeon"
hard_level.difficulty = 5
hard_level.enemies << Enemy.new("Orc", 100, 20, 3)
hard_level.enemies << Enemy.new("Troll", 200, 30, 2)
hard_level.loot << Weapon.new("Steel Sword", 40, 3, 1.2)
puts "Created: #{hard_level}"

puts "\n=== Key Takeaway ==="
puts "Prototype creates new objects by copying existing ones."
puts "Use when: object creation is expensive, or you need many similar objects."
puts "Ruby provides: clone (shallow + frozen), dup (shallow), Marshal (deep)"
puts "Common uses: Game entities, document templates, cached objects."
