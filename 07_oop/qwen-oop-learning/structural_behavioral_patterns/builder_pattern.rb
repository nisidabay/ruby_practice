#!/usr/bin/env ruby

# Builder Pattern — Construct Complex Objects Step by Step
# Core Idea: Separate the construction of a complex object from its representation
# so that the same construction process can create different representations.


# =============================================================================
# 1. THE PRODUCT
# =============================================================================

class House
  attr_accessor :foundation, :walls, :roof, :windows, :doors, :garage, :pool

  def initialize
    @foundation = nil
    @walls = nil
    @roof = nil
    @windows = 0
    @doors = 0
    @garage = false
    @pool = false
  end

  def to_s
    parts = []
    parts << "Foundation: #{@foundation}" if @foundation
    parts << "Walls: #{@walls}" if @walls
    parts << "Roof: #{@roof}" if @roof
    parts << "Windows: #{@windows}" if @windows > 0
    parts << "Doors: #{@doors}" if @doors > 0
    parts << "Garage" if @garage
    parts << "Pool" if @pool
    parts.join(", ") || "Empty house"
  end
end


# =============================================================================
# 2. THE BUILDER INTERFACE
# =============================================================================

class HouseBuilder
  def build_foundation; end
  def build_walls; end
  def build_roof; end
  def build_windows; end
  def build_doors; end
  def build_garage; end
  def build_pool; end

  def get_house
    raise NotImplementedError, "Subclasses must implement get_house()"
  end
end


# =============================================================================
# 3. CONCRETE BUILDERS
# =============================================================================

class WoodenHouseBuilder < HouseBuilder
  def initialize
    @house = House.new
  end

  def build_foundation
    @house.foundation = "Wooden beams"
    puts "  [Builder] Building wooden foundation"
  end

  def build_walls
    @house.walls = "Wooden planks"
    puts "  [Builder] Building wooden walls"
  end

  def build_roof
    @house.roof = "Wooden shingles"
    puts "  [Builder] Building wooden roof"
  end

  def build_windows
    @house.windows = 4
    puts "  [Builder] Installing 4 wooden windows"
  end

  def build_doors
    @house.doors = 2
    puts "  [Builder] Installing 2 wooden doors"
  end

  def build_garage
    @house.garage = true
    puts "  [Builder] Building wooden garage"
  end

  def build_pool
    # Wooden houses don't get pools by default
    puts "  [Builder] Skipping pool for wooden house"
  end

  def get_house
    @house
  end
end

class ConcreteHouseBuilder < HouseBuilder
  def initialize
    @house = House.new
  end

  def build_foundation
    @house.foundation = "Concrete slab"
    puts "  [Builder] Pouring concrete foundation"
  end

  def build_walls
    @house.walls = "Concrete blocks"
    puts "  [Builder] Building concrete walls"
  end

  def build_roof
    @house.roof = "Concrete tiles"
    puts "  [Builder] Installing concrete roof"
  end

  def build_windows
    @house.windows = 8
    puts "  [Builder] Installing 8 windows"
  end

  def build_doors
    @house.doors = 3
    puts "  [Builder] Installing 3 doors"
  end

  def build_garage
    @house.garage = true
    puts "  [Builder] Building concrete garage"
  end

  def build_pool
    @house.pool = true
    puts "  [Builder] Building concrete pool"
  end

  def get_house
    @house
  end
end

class GlassHouseBuilder < HouseBuilder
  def initialize
    @house = House.new
  end

  def build_foundation
    @house.foundation = "Steel frame"
    puts "  [Builder] Installing steel foundation"
  end

  def build_walls
    @house.walls = "Glass panels"
    puts "  [Builder] Installing glass walls"
  end

  def build_roof
    @house.roof = "Glass ceiling"
    puts "  [Builder] Installing glass roof"
  end

  def build_windows
    @house.windows = 20  # Lots of windows!
    puts "  [Builder] Installing 20 glass windows"
  end

  def build_doors
    @house.doors = 4
    puts "  [Builder] Installing 4 glass doors"
  end

  def build_garage
    puts "  [Builder] Skipping garage for glass house"
  end

  def build_pool
    @house.pool = true
    puts "  [Builder] Building infinity pool"
  end

  def get_house
    @house
  end
end


# =============================================================================
# 4. THE DIRECTOR
# =============================================================================
# Controls the construction process

class ConstructionDirector
  def initialize(builder)
    @builder = builder
  end

  def build_minimal_house
    puts "\n[Director] Building minimal house"
    @builder.build_foundation
    @builder.build_walls
    @builder.build_roof
    @builder.build_doors
    @builder.get_house
  end

  def build_standard_house
    puts "\n[Director] Building standard house"
    @builder.build_foundation
    @builder.build_walls
    @builder.build_roof
    @builder.build_windows
    @builder.build_doors
    @builder.get_house
  end

  def build_luxury_house
    puts "\n[Director] Building luxury house"
    @builder.build_foundation
    @builder.build_walls
    @builder.build_roof
    @builder.build_windows
    @builder.build_doors
    @builder.build_garage
    @builder.build_pool
    @builder.get_house
  end
end


# =============================================================================
# 5. FLUENT BUILDER (Modern Ruby Style)
# =============================================================================

class Car
  attr_accessor :make, :model, :year, :color, :engine, :wheels, :sunroof

  def initialize
    @make = nil
    @model = nil
    @year = nil
    @color = "white"
    @engine = "V6"
    @wheels = 17
    @sunroof = false
  end

  def to_s
    "#{@year} #{@make} #{@model} (#{@color}, #{@engine}, #{@wheels}\" wheels#{', sunroof' if @sunroof})"
  end
end

class CarBuilder
  def initialize
    @car = Car.new
  end

  def make(make)
    @car.make = make
    self
  end

  def model(model)
    @car.model = model
    self
  end

  def year(year)
    @car.year = year
    self
  end

  def color(color)
    @car.color = color
    self
  end

  def engine(engine)
    @car.engine = engine
    self
  end

  def wheels(size)
    @car.wheels = size
    self
  end

  def sunroof(enabled)
    @car.sunroof = enabled
    self
  end

  def build
    @car
  end
end


# =============================================================================
# 6. REAL-WORLD EXAMPLE: SQL Query Builder
# =============================================================================

class SQLQuery
  attr_accessor :table, :columns, :conditions, :order_by, :limit_value

  def initialize
    @columns = ["*"]
    @conditions = []
    @order_by = nil
    @limit_value = nil
  end

  def to_sql
    parts = ["SELECT #{@columns.join(", ")}"]
    parts << "FROM #{@table}" if @table
    parts << "WHERE #{@conditions.join(" AND ")}" if @conditions.any?
    parts << "ORDER BY #{@order_by}" if @order_by
    parts << "LIMIT #{@limit_value}" if @limit_value
    parts.join(" ")
  end
end

class SQLQueryBuilder
  def initialize
    @query = SQLQuery.new
  end

  def select(*columns)
    @query.columns = columns
    self
  end

  def from(table)
    @query.table = table
    self
  end

  def where(condition)
    @query.conditions << condition
    self
  end

  def order(column, direction = "ASC")
    @query.order_by = "#{column} #{direction}"
    self
  end

  def limit(count)
    @query.limit_value = count
    self
  end

  def build
    @query.to_sql
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Builder Pattern Demo ===\n\n"

# House building example
puts "--- Building Different House Types ---"

# Build wooden house
wooden_builder = WoodenHouseBuilder.new
director = ConstructionDirector.new(wooden_builder)
wooden_house = director.build_standard_house
puts "Wooden House: #{wooden_house}"

# Build concrete house
concrete_builder = ConcreteHouseBuilder.new
director = ConstructionDirector.new(concrete_builder)
concrete_house = director.build_luxury_house
puts "Concrete House: #{concrete_house}"

# Build glass house
glass_builder = GlassHouseBuilder.new
director = ConstructionDirector.new(glass_builder)
glass_house = director.build_minimal_house
puts "Glass House: #{glass_house}"

# Same process, different results
puts "\n--- Same Process, Different Results ---"
builders = [
  WoodenHouseBuilder.new,
  ConcreteHouseBuilder.new,
  GlassHouseBuilder.new
]

builders.each do |builder|
  director = ConstructionDirector.new(builder)
  house = director.build_standard_house
  puts "#{builder.class.name}: #{house}"
end

# Fluent builder example
puts "\n--- Fluent Car Builder ---"
car1 = CarBuilder.new
  .make("Toyota")
  .model("Camry")
  .year(2024)
  .color("blue")
  .engine("V6")
  .build

puts "Car 1: #{car1}"

car2 = CarBuilder.new
  .make("Tesla")
  .model("Model 3")
  .year(2024)
  .color("red")
  .engine("Electric")
  .wheels(19)
  .sunroof(true)
  .build

puts "Car 2: #{car2}"

car3 = CarBuilder.new
  .make("Ford")
  .model("Mustang")
  .year(1969)
  .color("black")
  .engine("V8")
  .wheels(20)
  .build

puts "Car 3: #{car3}"

# SQL Query Builder
puts "\n--- SQL Query Builder ---"
query1 = SQLQueryBuilder.new
  .select("id", "name", "email")
  .from("users")
  .where("active = true")
  .where("age > 18")
  .order("created_at", "DESC")
  .limit(10)
  .build

puts "Query 1: #{query1}"

query2 = SQLQueryBuilder.new
  .select("*")
  .from("products")
  .where("price < 100")
  .build

puts "Query 2: #{query2}"

puts "\n=== Key Takeaway ==="
puts "Builder separates construction from representation."
puts "Same construction process can create different products."
puts "Common uses: complex object creation, DSLs, query builders, configuration."
puts "Fluent interface (method chaining) makes builders more readable."
