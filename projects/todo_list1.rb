#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Todo List Manager
# This file implements a todo list management system.
# Demonstrates array manipulation and basic CRUD operations.

# Ruby Todo List - Fixed & Improved ✨

FILE_NAME = 'todos.txt'

def clear_screen
  print "\e[H\e[2J\e[3J"
end

def load_tasks
  return [] unless File.exist?(FILE_NAME)

  File.readlines(FILE_NAME).map(&:chomp).reject(&:empty?)
end

def save_tasks(todos)
  File.write(FILE_NAME, todos.join("\n") + "\n")
end

todos = load_tasks

loop do
  clear_screen
  puts '═' * 50
  puts '              ✨ MY TODO LIST ✨'.center(50)
  puts '═' * 50
  puts '1. ➕  Add new task'
  puts '2. 📋  View all tasks'
  puts '3. 🗑️  Delete a task'
  puts '4. 👋  Exit'
  puts '═' * 50

  print "\nSelect an option (1-4): "
  choice = gets.chomp.to_i

  case choice
  when 1 # Add
    clear_screen
    print 'What needs to be done? '
    task = gets.chomp.strip
    if task.empty?
      puts "\n⚠️ Task can't be empty!"
    else
      todos << task
      save_tasks(todos)
      puts "\n✅ Task added!"
    end

  when 2 # View
    clear_screen
    puts '📋 YOUR TASKS'
    puts '═' * 50
    if todos.empty?
      puts "\n🎉 Nothing to do — you're crushing it!"
    else
      todos.each_with_index { |t, i| puts " #{i + 1}. #{t}" }
    end

  when 3 # Delete
    if todos.empty?
      clear_screen
      puts '🎉 No tasks to delete!'
      sleep 1.5
      next
    end

    clear_screen
    puts '🗑️  DELETE TASK'
    puts '═' * 50
    todos.each_with_index { |t, i| puts " #{i + 1}. #{t}" }

    print "\nTask number to delete: "
    index = gets.chomp.to_i - 1

    if index.between?(0, todos.size - 1)
      deleted = todos.delete_at(index)
      save_tasks(todos)
      puts "\n🗑️ Deleted: #{deleted}"
    else
      puts "\n❌ Invalid number!"
    end

  when 4 # Exit
    clear_screen
    puts '👋 Goodbye! Keep being awesome ✨'
    break

  else
    puts "\n❌ Please choose a number between 1 and 4."
  end

  # Pause before next menu (except on exit)
  print "\nPress Enter to continue..." unless choice == 4
  gets unless choice == 4
end
