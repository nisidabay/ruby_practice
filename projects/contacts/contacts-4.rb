#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Contacts Management System
# This file implements a contacts management system with CRUD operations.
# Demonstrates object-oriented programming and file handling.

# Made with devstral-small-2:24b

require 'json'
require 'fileutils'

class ContactsBook
  def initialize(file_path = 'contacts.json')
    @file_path = file_path
    @contacts = load_contacts
  end

  def add_contact(name, email, phone, address = nil)
    contact = {
      name: name,
      email: email,
      phone: phone,
      address: address,
      created_at: Time.now.iso8601,
      updated_at: Time.now.iso8601,
    }
    @contacts << contact
    save_contacts
    puts "Contact '#{name}' added successfully!"
  end

  def list_contacts
    if @contacts.empty?
      puts 'No contacts found.'
      return
    end

    puts "\nContacts List (#{@contacts.size}):"
    @contacts.each_with_index do |contact, index|
      puts "#{index + 1}. #{contact[:name]} - #{contact[:email]} - #{contact[:phone]}"
    end
  end

  def find_contact(query)
    results = @contacts.select do |contact|
      contact[:name].downcase.include?(query.downcase) ||
        contact[:email].downcase.include?(query.downcase) ||
        contact[:phone].include?(query)
    end

    if results.empty?
      puts "No contacts found matching '#{query}'."
      return
    end

    puts "\nFound #{results.size} contact(s):"
    results.each_with_index do |contact, index|
      puts "#{index + 1}. #{contact[:name]} - #{contact[:email]} - #{contact[:phone]}"
    end
  end

  def update_contact(index, new_data)
    return unless index.between?(1, @contacts.size)

    contact = @contacts[index - 1]
    contact.merge!(new_data)
    contact[:updated_at] = Time.now.iso8601
    save_contacts
    puts "Contact '#{contact[:name]}' updated successfully!"
  end

  def delete_contact(index)
    return unless index.between?(1, @contacts.size)

    name = @contacts[index - 1][:name]
    @contacts.delete_at(index - 1)
    save_contacts
    puts "Contact '#{name}' deleted successfully!"
  end

  def export_contacts(file_path = 'contacts_export.json')
    File.write(file_path, JSON.pretty_generate(@contacts))
    puts "Contacts exported to #{file_path}"
  end

  def import_contacts(file_path)
    imported = JSON.parse(File.read(file_path))
    @contacts += imported
    save_contacts
    puts "Imported #{imported.size} contacts from #{file_path}"
  rescue Errno::ENOENT
    puts "File #{file_path} not found."
  rescue JSON::ParserError
    puts "Invalid JSON format in #{file_path}."
  end

  private

  def load_contacts
    return [] unless File.exist?(@file_path)

    begin
      JSON.parse(File.read(@file_path))
    rescue JSON::ParserError
      puts 'Warning: Corrupt contacts file. Starting with empty contacts.'
      []
    end
  end

  def save_contacts
    File.write(@file_path, JSON.pretty_generate(@contacts))
  end
end

class FileStorage
  def initialize(base_dir = 'storage')
    @base_dir = base_dir
    FileUtils.mkdir_p(@base_dir) unless Dir.exist?(@base_dir)
  end

  def upload_file(contact_name, file_path)
    contact_dir = File.join(@base_dir, contact_name.gsub(/\s+/, '_'))
    FileUtils.mkdir_p(contact_dir) unless Dir.exist?(contact_dir)

    file_name = File.basename(file_path)
    dest_path = File.join(contact_dir, file_name)

    if File.exist?(dest_path)
      puts 'File already exists. Overwriting...'
    end

    FileUtils.cp(file_path, dest_path)
    puts "File uploaded to #{dest_path}"
  end

  def list_files(contact_name = nil)
    if contact_name
      contact_dir = File.join(@base_dir, contact_name.gsub(/\s+/, '_'))
      return puts "No files found for #{contact_name}." unless Dir.exist?(contact_dir)

      files = Dir.glob(File.join(contact_dir, '*')).select { |f| File.file?(f) }
      puts "\nFiles for #{contact_name}:"
      files.each { |f| puts File.basename(f) }
    else
      puts "\nAll stored files:"
      Dir.glob(File.join(@base_dir, '*', '*')).select { |f| File.file?(f) }.each do |f|
        contact = File.basename(File.dirname(f))
        puts "#{contact}: #{File.basename(f)}"
      end
    end
  end

  def download_file(contact_name, file_name, dest_path = nil)
    contact_dir = File.join(@base_dir, contact_name.gsub(/\s+/, '_'))
    file_path = File.join(contact_dir, file_name)

    unless File.exist?(file_path)
      puts 'File not found.'
      return
    end

    dest_path ||= file_name
    FileUtils.cp(file_path, dest_path)
    puts "File downloaded to #{dest_path}"
  end

  def delete_file(contact_name, file_name)
    contact_dir = File.join(@base_dir, contact_name.gsub(/\s+/, '_'))
    file_path = File.join(contact_dir, file_name)

    if File.exist?(file_path)
      File.delete(file_path)
      puts "File deleted: #{file_name}"
    else
      puts 'File not found.'
    end
  end
end

class ContactsManagerCLI
  def initialize
    @contacts_book = ContactsBook.new
    @file_storage = FileStorage.new
  end

  def run
    puts 'Welcome to Contacts Book Manager!'
    loop do
      display_menu
      choice = gets.chomp.downcase

      case choice
      when '1' then add_contact
      when '2' then list_contacts
      when '3' then find_contact
      when '4' then update_contact
      when '5' then delete_contact
      when '6' then export_contacts
      when '7' then import_contacts
      when '8' then upload_file
      when '9' then list_files
      when '10' then download_file
      when '11' then delete_file
      when 'q' then break
      else puts 'Invalid choice. Please try again.'
      end
    end
    puts 'Goodbye!'
  end

  private

  def display_menu
    puts "\nContacts Book Manager"
    puts '1. Add Contact'
    puts '2. List Contacts'
    puts '3. Find Contact'
    puts '4. Update Contact'
    puts '5. Delete Contact'
    puts '6. Export Contacts'
    puts '7. Import Contacts'
    puts '8. Upload File'
    puts '9. List Files'
    puts '10. Download File'
    puts '11. Delete File'
    puts 'Q. Quit'
    print 'Choose an option: '
  end

  def add_contact
    print 'Enter name: '
    name = gets.chomp
    print 'Enter email: '
    email = gets.chomp
    print 'Enter phone: '
    phone = gets.chomp
    print 'Enter address (optional): '
    address = gets.chomp
    address = nil if address.empty?

    @contacts_book.add_contact(name, email, phone, address)
  end

  def list_contacts
    @contacts_book.list_contacts
  end

  def find_contact
    print 'Enter search term: '
    query = gets.chomp
    @contacts_book.find_contact(query)
  end

  def update_contact
    @contacts_book.list_contacts
    print 'Enter contact number to update: '
    index = gets.chomp.to_i

    print 'Enter new name (leave blank to keep current): '
    name = gets.chomp
    print 'Enter new email (leave blank to keep current): '
    email = gets.chomp
    print 'Enter new phone (leave blank to keep current): '
    phone = gets.chomp
    print 'Enter new address (leave blank to keep current): '
    address = gets.chomp

    updates = {}
    updates[:name] = name unless name.empty?
    updates[:email] = email unless email.empty?
    updates[:phone] = phone unless phone.empty?
    updates[:address] = address unless address.empty?

    @contacts_book.update_contact(index, updates)
  end

  def delete_contact
    @contacts_book.list_contacts
    print 'Enter contact number to delete: '
    index = gets.chomp.to_i
    @contacts_book.delete_contact(index)
  end

  def export_contacts
    print 'Enter export file path (default: contacts_export.json): '
    path = gets.chomp
    path = 'contacts_export.json' if path.empty?
    @contacts_book.export_contacts(path)
  end

  def import_contacts
    print 'Enter import file path: '
    path = gets.chomp
    @contacts_book.import_contacts(path)
  end

  def upload_file
    @contacts_book.list_contacts
    print 'Enter contact number: '
    index = gets.chomp.to_i
    contact = @contacts_book.instance_variable_get(:@contacts)[index - 1]
    print 'Enter file path to upload: '
    file_path = gets.chomp
    @file_storage.upload_file(contact[:name], file_path)
  end

  def list_files
    print 'Enter contact name (leave blank for all): '
    contact_name = gets.chomp
    contact_name = nil if contact_name.empty?
    @file_storage.list_files(contact_name)
  end

  def download_file
    print 'Enter contact name: '
    contact_name = gets.chomp
    print 'Enter file name: '
    file_name = gets.chomp
    print 'Enter destination path (leave blank to use current directory): '
    dest_path = gets.chomp
    dest_path = nil if dest_path.empty?
    @file_storage.download_file(contact_name, file_name, dest_path)
  end

  def delete_file
    print 'Enter contact name: '
    contact_name = gets.chomp
    print 'Enter file name: '
    file_name = gets.chomp
    @file_storage.delete_file(contact_name, file_name)
  end
end

# Start the application
ContactsManagerCLI.new.run if __FILE__ == $PROGRAM_NAME
