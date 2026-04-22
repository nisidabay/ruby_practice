#!/usr/bin/env ruby
# frozen_string_literal: true

# Object-Oriented Programming Examples
# This file demonstrates Ruby OOP concepts including:
# - Class methods vs instance methods
# - Inheritance (subclassing and super calls)
# - Polymorphism (method overriding)
# - Encapsulation (validation in setters)

# =============================================================================
# CLASS METHODS VS INSTANCE METHODS
# =============================================================================

# This script defines a Ruby class named `SchoolLibrary` that demonstrates both
# class methods and instance methods.
#
# - `return_name` is a class method that prints a message.
# - `version` is a class method that returns a version string.
# - `version_2` is an instance method that returns a different version string.
#
# The script shows how to invoke class methods directly on the class
# and how to create an instance to call instance methods.

class SchoolLibrary
  class << self
    def return_name
      puts 'The name is School'
    end

    def version
      '1.0.0'
    end
  end

  def version_2
    '1.0.1'
  end
end

puts "--- Class vs Instance Methods Demo ---"
# Demonstrate class methods
SchoolLibrary.return_name
puts SchoolLibrary.version

# Demonstrate instance method
lib = SchoolLibrary.new
puts lib.version_2

# =============================================================================
# INHERITANCE EXAMPLE
# =============================================================================

# Base class representing a generic Library
class Library
  attr_reader :name, :books

  def initialize(name)
    @name = name
    @books = []
  end

  def add_book(book)
    @books << book
  end

  def catalog
    "#{name} has #{books.count} books"
  end

  # Class method inherited by subclasses
  def self.library_type
    'Generic Library'
  end
end

# PublicLibrary inherits from Library
class PublicLibrary < Library
  def initialize(name, location)
    super(name) # Call Library's initialize
    @location = location
  end

  def info
    "#{name} - Public Library at #{@location}"
  end
end

# UniversityLibrary inherits from Library
class UniversityLibrary < Library
  def initialize(name, university_name)
    super(name)
    @university = university_name
  end

  def info
    "#{name} - #{@university} University Library"
  end

  # Override class method
  def self.library_type
    'Academic Library'
  end
end

puts "\n--- Inheritance Demo ---"
public_lib = PublicLibrary.new('City Books', 'Main Street')
public_lib.add_book('Ruby Programming')
puts public_lib.catalog  # Inherited method
puts public_lib.info      # PublicLibrary's method

uni_lib = UniversityLibrary.new('Tech Library', 'Stanford')
uni_lib.add_book('Computer Science 101')
puts uni_lib.catalog     # Inherited method
puts uni_lib.info        # UniversityLibrary's method

puts PublicLibrary.library_type
puts UniversityLibrary.library_type

# =============================================================================
# POLYMORPHISM EXAMPLE
# =============================================================================

# Polymorphism allows different library types to respond to the same messages
# Each subclass provides its own implementation

# Base class for library items
class LibraryItem
  attr_reader :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end

  def checkout(days)
    raise NotImplementedError, "Subclasses must implement #checkout"
  end

  def late_fee(days_late)
    raise NotImplementedError, "Subclasses must implement #late_fee"
  end
end

class Book < LibraryItem
  def checkout(days)
    "Book '#{title}' checked out for #{days} days"
  end

  def late_fee(days_late)
    days_late * 0.25 # $0.25 per day
  end
end

class DVD < LibraryItem
  def checkout(days)
    "DVD '#{title}' checked out for #{days} days (max 7)"
  end

  def late_fee(days_late)
    days_late * 1.00 # $1.00 per day
  end
end

class Magazine < LibraryItem
  def checkout(days)
    "Magazine '#{title}' checked out for #{days} days (cannot renew)"
  end

  def late_fee(days_late)
    days_late * 0.10 # $0.10 per day
  end
end

# Polymorphic method - works with any LibraryItem
def process_checkout(items, checkout_days)
  puts "\nProcessing checkouts for #{checkout_days} days:"
  items.each do |item|
    puts "  - #{item.checkout(checkout_days)}"
    puts "    Late fee for 3 days: $#{item.late_fee(3)}"
  end
end

puts "\n--- Polymorphism Demo ---"
items = [
  Book.new('The Ruby Way', 'Hal Fulton'),
  DVD.new('Inception', 'Christopher Nolan'),
  Magazine.new('Ruby Weekly', 'Various')
]
process_checkout(items, 14)

# =============================================================================
# ENCAPSULATION EXAMPLE
# =============================================================================

# Encapsulation hides internal state and requires interaction through
# well-defined methods with validation

class BankAccount
  # Private constants - encapsulated
  MIN_BALANCE = 0
  MAX_WITHDRAWAL = 10_000

  # Public read-only access
  attr_reader :owner, :balance

  def initialize(owner, initial_deposit)
    @owner = owner
    @balance = 0
    deposit(initial_deposit) # Use validated method
  end

  # Public methods with validation (encapsulation)
  def deposit(amount)
    raise 'Deposit must be positive' unless amount > 0

    @balance += amount
    log_transaction('Deposit', amount)
  end

  def withdraw(amount)
    validate_withdrawal(amount)
    @balance -= amount
    log_transaction('Withdrawal', amount)
    amount
  end

  # Private methods - encapsulated logic
  private

  def validate_withdrawal(amount)
    raise 'Withdrawal must be positive' unless amount > 0
    raise "Insufficient funds. Balance: #{@balance}" if amount > @balance
    raise "Exceeds max withdrawal of $#{MAX_WITHDRAWAL}" if amount > MAX_WITHDRAWAL
  end

  def log_transaction(type, amount)
    puts "[LOG] #{type}: $#{amount} | New Balance: $#{@balance}"
  end
end

puts "\n--- Encapsulation Demo ---"
account = BankAccount.new('Alice', 1000)
account.deposit(500)
account.withdraw(200)
# account.balance = 5000  # Error - no setter (encapsulated)
# account.withdraw(2000)  # Error - insufficient funds (validation)
# account.withdraw(15_000) # Error - exceeds max (validation)