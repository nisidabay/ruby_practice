#!/usr/bin/env ruby

# Iterator Pattern — Traverse Collections Without Exposing Structure
# Core Idea: Provide a way to access elements of a collection sequentially
# without exposing the underlying representation.


# =============================================================================
# 1. THE ITERATOR INTERFACE
# =============================================================================
# All iterators must implement these methods.

class Iterator
  def first; end
  def next; end
  def current; end
  def done?; end
end


# =============================================================================
# 2. THE AGGREGATE (COLLECTION) INTERFACE
# =============================================================================
# Collections that can be iterated must implement this.

class Aggregate
  def create_iterator
    raise NotImplementedError, "Subclasses must implement create_iterator()"
  end
end


# =============================================================================
# 3. CONCRETE ITERATOR
# =============================================================================
# Implements iteration logic for a specific collection type.

class Book
  attr_reader :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end

  def to_s
    "\"#{@title}\" by #{@author}"
  end
end

class BookIterator < Iterator
  def initialize(books)
    @books = books
    @index = 0
  end

  def first
    @index = 0
  end

  def next
    @index += 1
  end

  def current
    @books[@index]
  end

  def done?
    @index >= @books.length
  end
end

# Alternative iterator: Only fiction books
class FictionBookIterator < Iterator
  def initialize(books)
    @books = books.select { |b| b.author.start_with?("J.K.", "J.R.R.", "George") }
    @index = 0
  end

  def first
    @index = 0
  end

  def next
    @index += 1
  end

  def current
    @books[@index]
  end

  def done?
    @index >= @books.length
  end
end


# =============================================================================
# 4. CONCRETE AGGREGATE
# =============================================================================
# The collection that creates iterators.

class BookCollection < Aggregate
  def initialize
    @books = []
  end

  def add_book(book)
    @books << book
  end

  def create_iterator
    BookIterator.new(@books)
  end

  def create_fiction_iterator
    FictionBookIterator.new(@books)
  end

  def length
    @books.length
  end
end


# =============================================================================
# 5. RUBY'S BUILT-IN ITERATOR (Enumerable)
# =============================================================================
# Ruby has this pattern built-in via Enumerable module.

class Playlist
  include Enumerable

  def initialize
    @songs = []
  end

  def add_song(title, duration)
    @songs << { title: title, duration: duration }
  end

  # Required by Enumerable - defines how to iterate
  def each
    @songs.each { |song| yield song }
  end

  def total_duration
    @songs.sum { |s| s[:duration] }
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Iterator Pattern Demo ===\n\n"

# Custom iterator
puts "--- Custom Book Collection ---"
collection = BookCollection.new
collection.add_book(Book.new("1984", "George Orwell"))
collection.add_book(Book.new("Harry Potter", "J.K. Rowling"))
collection.add_book(Book.new("The Hobbit", "J.R.R. Tolkien"))
collection.add_book(Book.new("Clean Code", "Robert Martin"))

puts "\nAll books:"
iterator = collection.create_iterator
iterator.first
until iterator.done?
  puts "  - #{iterator.current}"
  iterator.next
end

puts "\nFiction only:"
fiction_iter = collection.create_fiction_iterator
fiction_iter.first
until fiction_iter.done?
  puts "  - #{fiction_iter.current}"
  fiction_iter.next
end

# Ruby's built-in Enumerable
puts "\n--- Ruby's Built-in Enumerable ---"
playlist = Playlist.new
playlist.add_song("Bohemian Rhapsody", 354)
playlist.add_song("Stairway to Heaven", 482)
playlist.add_song("Hotel California", 390)

puts "\nUsing each:"
playlist.each { |song| puts "  - #{song[:title]} (#{song[:duration]}s)" }

puts "\nUsing select (from Enumerable):"
playlist.select { |s| s[:duration] > 400 }.each { |s| puts "  - #{s[:title]}" }

puts "\nUsing map (from Enumerable):"
puts "Song titles: #{playlist.map { |s| s[:title] }.join(", ")}"

puts "\nTotal duration: #{playlist.total_duration} seconds"

puts "\n=== Key Takeaway ==="
puts "Iterator separates traversal logic from collection structure."
puts "Ruby's Enumerable module provides this pattern built-in!"
