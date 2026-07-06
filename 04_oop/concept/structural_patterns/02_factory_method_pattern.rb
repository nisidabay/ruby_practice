#!/usr/bin/env ruby
# frozen_string_literal: true

# factory_method_pattern.rb — subclasses decide which class to instantiate

class Document
  def open; end
  def save; end
  def close; end
end

class PDFDocument < Document
  def open  = puts("  [PDF] Opening PDF...")
  def save  = puts("  [PDF] Saving PDF...")
  def close = puts("  [PDF] Closing PDF...")
end

class WordDocument < Document
  def open  = puts("  [Word] Opening Word...")
  def save  = puts("  [Word] Saving Word...")
  def close = puts("  [Word] Closing Word...")
end

class Application
  def create_document
    raise NotImplementedError
  end

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
    PDFDocument.new
  end
end

class WordApplication < Application
  def create_document
    WordDocument.new
  end
end

pdf_app = PDFApplication.new
doc1 = pdf_app.new_document
pdf_app.save_document(doc1)

word_app = WordApplication.new
doc2 = word_app.new_document
word_app.save_document(doc2)


# Thinking in Ruby
#
# The Factory Method pattern: the Application class defines
# create_document as an abstract hook (raise NotImplementedError), and
# subclasses decide which Document type to instantiate. Client code
# calls new_document and save_document without knowing the concrete
# class — polymorphism without if/elsif or case statements.
