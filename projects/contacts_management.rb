#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Contacts Management System
# This file implements a contacts management system with CRUD operations.
# Demonstrates object-oriented programming and file handling.

# Made with glm-4.7-flash:latest
require 'json'
require 'fileutils' # Needed for the backup copy feature

# 1. Data Model: A simple Struct to represent a Contact
Contact = Struct.new(:name, :phone, :email, keyword_init: true)

class ContactBook
  FILE_PATH = File.join(__dir__, 'contacts.json')

  def initialize
    @contacts = load_contacts
  end

  # CREATE and READ
  def list_contacts
    return puts 'No contacts found.' if @contacts.empty?

    puts "\n--- Contacts List ---"
    @contacts.each_with_index do |contact, index|
      puts "[#{index + 1}] #{contact.name}"
      puts "   Phone: #{contact.phone}"
      puts "   Email: #{contact.email}"
      puts '----------------------'
    end
  end

  def enter_contact
    print 'Enter Name: '
    name = gets.chomp

    # Validation loop
    while name.strip.empty?
      puts 'Name cannot be empty.'
      print 'Enter Name: '
      name = gets.chomp
    end

    print 'Enter Phone: '
    phone = gets.chomp
    while phone.strip.empty?
      puts 'Phone cannot be empty.'
      print 'Enter Phone: '
      phone = gets.chomp
    end

    print 'Enter Email: '
    email = gets.chomp
    while email.strip.empty?
      puts 'Email cannot be empty.'
      print 'Enter Email: '
      email = gets.chomp
    end

    [name, phone, email]
  end

  def add_contact(name:, phone:, email:)
    new_contact = Contact.new(name: name, phone: phone, email: email)
    @contacts << new_contact
    save_contacts
    puts "\nContact '#{name}' added successfully!"
  end

  # UPDATE
  def update_contact(name)
    contact = find_contact_by_name(name)
    return puts "\nContact '#{name}' not found." unless contact

    puts "\nUpdating #{contact.name}:"
    print "New Phone [Current: #{contact.phone}]: "
    phone = gets.chomp
    print "New Email [Current: #{contact.email}]: "
    email = gets.chomp

    contact.phone = phone unless phone.empty?
    contact.email = email unless email.empty?

    save_contacts
    puts "\nContact updated."
  end

  # DELETE
  def delete_contact(name)
    index = @contacts.index { |c| c.name == name }
    return puts "\nContact '#{name}' not found." if index.nil?

    @contacts.delete_at(index)
    save_contacts
    puts "\nContact '#{name}' deleted."
  end

  # SEARCH
  def find_contact(name)
    contact = @contacts.find { |c| c.name.downcase == name.downcase }
    if contact
      puts "\n--- Found Contact ---"
      puts "Name: #{contact.name}"
      puts "Phone: #{contact.phone}"
      puts "Email: #{contact.email}"
    else
      puts "\nContact not found."
    end
  end

  # BACKUP
  def backup_contacts
    if File.exist?(FILE_PATH)
      backup_path = "#{FILE_PATH}.bak"
      FileUtils.cp(FILE_PATH, backup_path)
      puts "\nBackup successfully created at: #{backup_path}"
    else
      puts "\nNo contacts file exists yet to backup."
    end
  end

  private

  def load_contacts
    return [] unless File.exist?(FILE_PATH)

    begin
      raw = JSON.parse(File.read(FILE_PATH), symbolize_names: true)
      raw.map { |h| Contact.new(name: h[:name], phone: h[:phone], email: h[:email]) }
    rescue JSON::ParserError
      puts 'Error: Corrupted data file found. Starting with an empty book.'
      []
    end
  end

  def save_contacts
    data = @contacts.map(&:to_h)
    File.write(FILE_PATH, JSON.pretty_generate(data))
  end

  def find_contact_by_name(name)
    @contacts.find { |c| c.name.downcase == name.downcase }
  end
end

# 2. Main CLI Interaction
def display_menu
  puts "\n======================================"
  puts '       CONTACT BOOK MANAGER'
  puts '======================================'
  puts '1. List all contacts'
  puts '2. Add a new contact'
  puts '3. Update a contact'
  puts '4. Find a contact'
  puts '5. Delete a contact'
  puts '6. Backup contacts'
  puts '7. Exit'
  puts '======================================'
  print 'Choose an option (1-7): '
end

def run
  book = ContactBook.new

  loop do
    system('clear') || system('cls')

    display_menu
    choice = gets.chomp

    case choice
    when '1'
      book.list_contacts
    when '2'
      name, phone, email = book.enter_contact
      book.add_contact(name: name, phone: phone, email: email)
    when '3'
      print 'Enter Name to update: '
      name = gets.chomp
      book.update_contact(name)
    when '4'
      print 'Enter Name to search: '
      name = gets.chomp
      book.find_contact(name)
    when '5'
      print 'Enter Name to delete: '
      name = gets.chomp
      book.delete_contact(name)
    when '6'
      book.backup_contacts
    when '7'
      puts 'Goodbye!'
      break
    else
      puts 'Invalid option. Please try again.'
    end

    puts "\nPress Enter to continue..."
    gets
  end
end

# 3. Start the program and catch Ctrl+C safely
begin
  run
rescue Interrupt
  puts "\n\nProgram interrupted by user. Goodbye!"
  exit
end
