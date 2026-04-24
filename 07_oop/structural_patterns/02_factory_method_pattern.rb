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

# This could also be done like this:
# For simple cases, use a parameterized factory method:
#
# class DocumentFactory
#   def self.create(type)
#     case type
#     when "pdf" then PDFDocument.new
#     when "word" then WordDocument.new
#     end
#   end
# end
#
# doc = DocumentFactory.create("pdf")
# doc.open
