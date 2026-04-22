#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Contacts Management System
# This file implements a contacts management system with CRUD operations.
# Demonstrates object-oriented programming and file handling.

# Made with minimax-m2.5:cloud
require 'yaml'
require 'fileutils'

class Contact
  attr_accessor :name, :phone, :email, :address

  def initialize(name, phone = '', email = '', address = '')
    @name = name
    @phone = phone
    @email = email
    @address = address
  end

  def to_h
    { name: @name, phone: @phone, email: @email, address: @address }
  end

  def self.from_hash(hash)
    new(hash[:name], hash[:phone], hash[:email], hash[:address])
  end

  def to_s
    "Name: #{@name}\n  Phone: #{@phone}\n  Email: #{@email}\n  Address: #{@address}"
  end
end

class ContactBook
  DEFAULT_FILE = 'contacts.yml'

  def initialize(filename = DEFAULT_FILE)
    @filename = filename
    @contacts = []
    load_contacts
  end

  def add_contact(contact)
    @contacts << contact
    save_contacts
  end

  def list_contacts
    if @contacts.empty?
      puts 'No contacts found.'
    else
      @contacts.each_with_index do |contact, index|
        puts "#{index + 1}. #{contact.name} - #{contact.phone}"
      end
    end
  end

  def find_contact(query)
    @contacts.select do |contact|
      contact.name.include?(query) || contact.phone.include?(query) || contact.email.include?(query)
    end
  end

  def delete_contact(index)
    if index >= 0 && index < @contacts.length
      @contacts.delete_at(index)
      save_contacts
      true
    else
      false
    end
  end

  def save_contacts
    File.open(@filename, 'w') do |file|
      YAML.dump(@contacts.map(&:to_h), file)
    end
  end

  def load_contacts
    if File.exist?(@filename)
      data = YAML.load_file(@filename)
      @contacts = data.map { |hash| Contact.from_hash(hash) } if data
    end
  end
end

# Main program
puts 'Welcome to Contact Book!'
book = ContactBook.new

loop do
  puts "\n--- Menu ---"
  puts '1. Add contact'
  puts '2. List contacts'
  puts '3. Search contacts'
  puts '4. Delete contact'
  puts '5. Exit'
  print 'Choose option: '
  choice = gets.chomp

  case choice
  when '1'
    print 'Name: '
    name = gets.chomp
    print 'Phone: '
    phone = gets.chomp
    print 'Email: '
    email = gets.chomp
    print 'Address: '
    address = gets.chomp
    book.add_contact(Contact.new(name, phone, email, address))
    puts 'Contact added!'

  when '2'
    book.list_contacts

  when '3'
    print 'Search: '
    query = gets.chomp
    results = book.find_contact(query)
    if results.any?
      results.each { |c| puts c }
    else
      puts 'No matches found.'
    end

  when '4'
    print 'Number to delete: '
    index = gets.chomp.to_i - 1
    if book.delete_contact(index)
      puts 'Contact deleted.'
    else
      puts 'Invalid number.'
    end

  when '5'
    puts 'Goodbye!'
    break

  else
    puts 'Invalid option.'
  end
end
