#!/usr/bin/env ruby

# Factory Method Pattern — Delegate Instantiation to Subclasses
# Core Idea: Define an interface for creating an object, but let subclasses decide
# which class to instantiate. Factory Method lets a class defer instantiation to subclasses.


# =============================================================================
# 1. THE PRODUCT INTERFACE
# =============================================================================

class Document
  def open; end
  def save; end
  def close; end

  def type
    self.class.name
  end
end


# =============================================================================
# 2. CONCRETE PRODUCTS
# =============================================================================

class PDFDocument < Document
  def open
    puts "  [PDF] Opening PDF document..."
  end

  def save
    puts "  [PDF] Saving PDF document..."
  end

  def close
    puts "  [PDF] Closing PDF document..."
  end
end

class WordDocument < Document
  def open
    puts "  [Word] Opening Word document..."
  end

  def save
    puts "  [Word] Saving Word document..."
  end

  def close
    puts "  [Word] Closing Word document..."
  end
end

class ExcelDocument < Document
  def open
    puts "  [Excel] Opening spreadsheet..."
  end

  def save
    puts "  [Excel] Saving spreadsheet..."
  end

  def close
    puts "  [Excel] Closing spreadsheet..."
  end
end


# =============================================================================
# 3. THE CREATOR (with Factory Method)
# =============================================================================

class Application
  # Factory Method - subclasses override this
  def create_document
    raise NotImplementedError, "Subclasses must implement create_document()"
  end

  # Template Method - uses the factory method
  def new_document
    doc = create_document
    doc.open
    doc
  end

  def save_document(doc)
    doc.save
    doc.close
  end
end


# =============================================================================
# 4. CONCRETE CREATORS
# =============================================================================

class PDFApplication < Application
  def create_document
    puts "  [Factory] Creating PDFDocument"
    PDFDocument.new
  end
end

class WordApplication < Application
  def create_document
    puts "  [Factory] Creating WordDocument"
    WordDocument.new
  end
end

class ExcelApplication < Application
  def create_document
    puts "  [Factory] Creating ExcelDocument"
    ExcelDocument.new
  end
end


# =============================================================================
# 5. PARAMETERIZED FACTORY METHOD
# =============================================================================

class DocumentFactory
  def self.create(type)
    case type.downcase
    when "pdf"
      puts "  [Factory] Creating PDFDocument"
      PDFDocument.new
    when "word", "doc", "docx"
      puts "  [Factory] Creating WordDocument"
      WordDocument.new
    when "excel", "xls", "xlsx"
      puts "  [Factory] Creating ExcelDocument"
      ExcelDocument.new
    else
      raise "Unknown document type: #{type}"
    end
  end
end


# =============================================================================
# 6. REAL-WORLD EXAMPLE: UI Framework
# =============================================================================

class Button
  def render; end
  def click; end
end

class WindowsButton < Button
  def render
    puts "  [WindowsButton] Rendering Windows-style button"
  end

  def click
    puts "  [WindowsButton] Clicked!"
  end
end

class MacButton < Button
  def render
    puts "  [MacButton] Rendering Mac-style button"
  end

  def click
    puts "  [MacButton] Clicked!"
  end
end

class LinuxButton < Button
  def render
    puts "  [LinuxButton] Rendering GTK button"
  end

  def click
    puts "  [LinuxButton] Clicked!"
  end
end

class Dialog
  # Factory Method
  def create_button
    raise NotImplementedError
  end

  def render
    puts "\n[Dialog] Rendering dialog"
    button = create_button
    button.render
    button
  end
end

class WindowsDialog < Dialog
  def create_button
    WindowsButton.new
  end
end

class MacDialog < Dialog
  def create_button
    MacButton.new
  end
end

class LinuxDialog < Dialog
  def create_button
    LinuxButton.new
  end
end


# =============================================================================
# 7. REAL-WORLD EXAMPLE: Shipping Calculators
# =============================================================================

class ShippingCalculator
  # Factory Method
  def create_calculator(order)
    raise NotImplementedError
  end

  def calculate(order)
    calculator = create_calculator(order)
    calculator.calculate
  end
end

class GroundShipping < ShippingCalculator
  def create_calculator(order)
    puts "  [Factory] Creating GroundShippingCalculator"
    GroundShippingCalculator.new(order)
  end
end

class AirShipping < ShippingCalculator
  def create_calculator(order)
    puts "  [Factory] Creating AirShippingCalculator"
    AirShippingCalculator.new(order)
  end
end

class SeaShipping < ShippingCalculator
  def create_calculator(order)
    puts "  [Factory] Creating SeaShippingCalculator"
    SeaShippingCalculator.new(order)
  end
end

class GroundShippingCalculator
  def initialize(order)
    @order = order
  end

  def calculate
    puts "  [Ground] Calculating: $#{@order[:weight]} * 2 = $#{@order[:weight] * 2}"
  end
end

class AirShippingCalculator
  def initialize(order)
    @order = order
  end

  def calculate
    puts "  [Air] Calculating: $#{@order[:weight]} * 5 = $#{@order[:weight] * 5}"
  end
end

class SeaShippingCalculator
  def initialize(order)
    @order = order
  end

  def calculate
    puts "  [Sea] Calculating: $#{@order[:weight]} * 1 = $#{@order[:weight] * 1}"
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Factory Method Pattern Demo ===\n\n"

# Application example
puts "--- Document Applications ---"
pdf_app = PDFApplication.new
word_app = WordApplication.new

doc1 = pdf_app.new_document
pdf_app.save_document(doc1)

doc2 = word_app.new_document
word_app.save_document(doc2)

# Parameterized factory
puts "\n--- Parameterized Factory ---"
doc3 = DocumentFactory.create("pdf")
doc3.open

doc4 = DocumentFactory.create("word")
doc4.open

doc5 = DocumentFactory.create("excel")
doc5.open

# UI Framework
puts "\n--- UI Framework (Cross-Platform Buttons) ---"
os = "mac"  # Could be detected from system

dialog = case os
         when "windows" then WindowsDialog.new
         when "mac" then MacDialog.new
         else LinuxDialog.new
         end

button = dialog.render
button.click

# Shipping calculators
puts "\n--- Shipping Calculators ---"
order = { weight: 10, destination: "NYC" }

ground = GroundShipping.new
ground.calculate(order)

air = AirShipping.new
air.calculate(order)

sea = SeaShipping.new
sea.calculate(order)

puts "\n=== Key Takeaway ==="
puts "Factory Method delegates object creation to subclasses."
puts "The creator knows about the interface, not concrete classes."
puts "Common uses: UI frameworks, plugins, document types, shipping methods."
