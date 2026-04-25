#!/usr/bin/env ruby

# Problem: You want subclasses to decide which class to instantiate.
# Example: A document editor that creates PDF, Word, or Excel documents based on user choice.
#
# Solution: Define a factory method that subclasses override to return concrete products.
# Visibility: Factory method is overridden by subclasses, client uses the interface.

class Document
  def open; end
  def save; end
  def close; end
end

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

class Application
  # Factory method - subclasses override this
  def create_document
    raise NotImplementedError, "Subclasses must implement create_document"
  end

  # Uses the factory method
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

# Usage: Create concrete applications that decide which document to create
pdf_app = PDFApplication.new
doc1 = pdf_app.new_document
pdf_app.save_document(doc1)

word_app = WordApplication.new
doc2 = word_app.new_document
word_app.save_document(doc2)

# Alternative: Parameterized factory method for simple cases
# For simple cases, use a parameterized factory method:

class SimpleDocumentFactory
  def self.create(type)
    case type
    when "pdf"
      puts "  [Factory] Creating PDFDocument"
      PDFDocument.new
    when "word"
      puts "  [Factory] Creating WordDocument"
      WordDocument.new
    when "excel"
      puts "  [Factory] Creating ExcelDocument"
      ExcelDocument.new
    else
      raise ArgumentError, "Unknown document type: #{type}"
    end
  end
end

class ExcelDocument < Document
  def open
    puts "  [Excel] Opening Excel spreadsheet..."
  end

  def save
    puts "  [Excel] Saving Excel spreadsheet..."
  end

  def close
    puts "  [Excel] Closing Excel spreadsheet..."
  end
end

puts "\n--- Parameterized Factory ---"

doc1 = SimpleDocumentFactory.create("pdf")
doc1.open

doc2 = SimpleDocumentFactory.create("word")
doc2.open

doc3 = SimpleDocumentFactory.create("excel")
doc3.open
