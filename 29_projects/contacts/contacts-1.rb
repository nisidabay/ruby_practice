#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Contacts Management System
# This file implements a contacts management system with CRUD operations.
# Demonstrates object-oriented programming and file handling.

# Made with qwen3-coder:30b
require 'json'
require 'fileutils'

class Contact
  attr_accessor :name, :email, :phone

  def initialize(name, email, phone)
    @name = name
    @email = email
    @phone = phone
  end

  def to_hash
    {
      name: @name,
      email: @email,
      phone: @phone,
    }
  end

  def to_s
    "Name: #{@name}, Email: #{@email}, Phone: #{@phone}"
  end
end

class ContactsBook
  FILE_PATH = 'contacts.json'.freeze

  def initialize
    @contacts = []
    load_contacts
  end

  def add_contact(name, email, phone)
    contact = Contact.new(name, email, phone)
    @contacts << contact
    save_contacts
    puts 'Contact added successfully!'
  end

  def list_contacts
    if @contacts.empty?
      puts 'No contacts found.'
    else
      puts "\n--- Contacts ---"
      @contacts.each_with_index do |contact, index|
        puts "#{index + 1}. #{contact}"
      end
      puts '---'
    end
  end

  def find_contact(name)
    contact = @contacts.find { |c| c.name.downcase == name.downcase }
    puts contact || 'Contact not found.'
  end

  def update_contact(name, new_email = nil, new_phone = nil)
    contact = @contacts.find { |c| c.name.downcase == name.downcase }
    if contact
      contact.email = new_email if new_email
      contact.phone = new_phone if new_phone
      save_contacts
      puts 'Contact updated successfully!'
    else
      puts 'Contact not found.'
    end
  end

  def delete_contact(name)
    contact = @contacts.find { |c| c.name.downcase == name.downcase }
    if contact
      @contacts.delete(contact)
      save_contacts
      puts 'Contact deleted successfully!'
    else
      puts 'Contact not found.'
    end
  end

  private

  def load_contacts
    if File.exist?(FILE_PATH)
      data = JSON.parse(File.read(FILE_PATH))
      @contacts = data.map do |contact_data|
        Contact.new(contact_data['name'], contact_data['email'], contact_data['phone'])
      end
    else
      # Create empty file if it doesn't exist
      File.write(FILE_PATH, '[]')
    end
  end

  def save_contacts
    File.write(FILE_PATH, JSON.pretty_generate(@contacts.map(&:to_hash)))
  end
end

# Main program
def main
  contacts_book = ContactsBook.new

  loop do
    puts "\n--- Contacts Book ---"
    puts '1. Add Contact'
    puts '2. List Contacts'
    puts '3. Find Contact'
    puts '4. Update Contact'
    puts '5. Delete Contact'
    puts '6. Exit'
    print 'Choose an option (1-6): '

    choice = gets.chomp

    case choice
    when '1'
      print 'Enter name: '
      name = gets.chomp
      print 'Enter email: '
      email = gets.chomp
      print 'Enter phone: '
      phone = gets.chomp
      contacts_book.add_contact(name, email, phone)
    when '2'
      contacts_book.list_contacts
    when '3'
      print 'Enter name to search: '
      name = gets.chomp
      contacts_book.find_contact(name)
    when '4'
      print 'Enter name to update: '
      name = gets.chomp
      print 'Enter new email (or press Enter to skip): '
      new_email = gets.chomp
      new_email = nil if new_email.empty?
      print 'Enter new phone (or press Enter to skip): '
      new_phone = gets.chomp
      new_phone = nil if new_phone.empty?
      contacts_book.update_contact(name, new_email, new_phone)
    when '5'
      print 'Enter name to delete: '
      name = gets.chomp
      contacts_book.delete_contact(name)
    when '6'
      puts 'Goodbye!'
      break
    else
      puts 'Invalid option. Please try again.'
    end
  end
end

# Run the program if this file is executed directly
if __FILE__ == $0
  main
end
