#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Contacts Management System
# This file implements a contacts management system with CRUD operations.
# Demonstrates object-oriented programming and file handling.

# Made with gemini 2.5 Pro
require 'json'

class ContactBook
  def initialize(file_path)
    @file_path = file_path
    @contacts = load_contacts
  end

  def load_contacts
    if File.exist?(@file_path)
      content = File.read(@file_path)
      content.strip.empty? ? [] : JSON.parse(content, symbolize_names: true)
    else
      []
    end
  end

  def save_contacts
    File.write(@file_path, JSON.pretty_generate(@contacts))
  end

  def add_contact(name, phone_number)
    if name.strip.empty? || phone_number.strip.empty?
      puts 'Name and phone number cannot be empty.'
      return
    end
    @contacts << { name: name, phone_number: phone_number }
    save_contacts
    puts 'Contact added successfully.'
  end

  def view_contacts
    puts 'Contacts in the book:'
    @contacts.each_with_index do |contact, index|
      puts "#{index + 1}. Name: #{contact[:name]}, Phone: #{contact[:phone_number]}"
    end
  end

  def update_contact(index, name, phone_number)
    if index >= 0 && index < @contacts.length
      if name.strip.empty? || phone_number.strip.empty?
        puts 'Name and phone number cannot be empty.'
        return
      end
      @contacts[index][:name] = name
      @contacts[index][:phone_number] = phone_number
      save_contacts
      puts 'Contact updated successfully.'
    else
      puts 'Invalid contact index.'
    end
  end

  def delete_contact(index)
    if index >= 0 && index < @contacts.length
      @contacts.delete_at(index)
      save_contacts
      puts 'Contact deleted successfully.'
    else
      puts 'Invalid contact index.'
    end
  end

  def main_menu
    loop do
      puts 'Contact Book Menu'
      puts '1. Add Contact'
      puts '2. View Contacts'
      puts '3. Update Contact'
      puts '4. Delete Contact'
      puts '5. Exit'
      puts 'Enter your choice: '
      choice = gets.chomp.to_i

      case choice
      when 1
        print 'Enter name: '
        name = gets.chomp
        print 'Enter phone number: '
        phone_number = gets.chomp
        add_contact(name, phone_number)
      when 2
        view_contacts
      when 3
        print 'Enter contact number to update: '
        index = gets.chomp.to_i - 1
        print 'Enter new name: '
        name = gets.chomp
        print 'Enter new phone number: '
        phone_number = gets.chomp
        update_contact(index, name, phone_number)
      when 4
        print 'Enter contact number to delete: '
        index = gets.chomp.to_i - 1
        delete_contact(index)
      when 5
        break
      else
        puts 'Invalid choice. Please try again.'
      end
    end
  end
end

# Initialize the contact book with a file path
contact_book = ContactBook.new('contacts.json')

# Start the main menu
contact_book.main_menu
