#!/usr/bin/env ruby
# frozen_string_literal: true
# Beautiful Todo List with Gum ✨ (100% working now)
# Todo List Manager
# This file implements a todo list management system.
# Demonstrates array manipulation and basic CRUD operations.


require 'gum'

FILE_NAME = 'todos.txt'

def clear_screen
  print "\e[H\e[2J\e[3J"
end

def load_tasks
  return [] unless File.exist?(FILE_NAME)

  File.readlines(FILE_NAME).map(&:chomp).reject(&:empty?)
end

def save_tasks(todos)
  Gum.spin('💾 Saving your tasks...', spinner: :dot) do
    File.write(FILE_NAME, todos.join("\n") + "\n")
  end
end

todos = load_tasks

loop do
  clear_screen

  puts Gum.style('📋  TODO LIST', foreground: '#FF79C6', bold: true, border: :rounded, padding: '1 4', width: 60)
  puts Gum.style("   #{todos.size} task#{'s' unless todos.size == 1}", foreground: '#BD93F9', italic: true)
  puts Gum.style('═' * 60, foreground: '#44475A')

  choice = Gum.choose(
    ['➕  Add Task', '📋  View Tasks', '🗑️  Delete Task', '👋  Exit'],
    header: 'What would you like to do?',
    height: 12,
  )

  case choice
  when '➕  Add Task'
    clear_screen
    task = Gum.input(
      header: '➕  New Task',
      placeholder: 'Buy milk, finish report, call mom...',
      width: 70,
      char_limit: 500,
    )

    if task && !task.strip.empty?
      todos << task.strip
      save_tasks(todos)
      puts "\n"
      puts Gum.style('✅ Task added!', foreground: '#50FA7B', bold: true)
    else
      puts Gum.style('⚠️  Task cannot be empty.', foreground: '#FFB86C')
    end

  when '📋  View Tasks'
    clear_screen
    puts Gum.style('📋  YOUR TASKS', foreground: '#50FA7B', bold: true, border: :double, padding: '1 3')

    if todos.empty?
      puts "\n"
      puts Gum.style("🎉 No tasks — you're unstoppable!", foreground: '#FFB86C', bold: true)
    else
      data = todos.map.with_index { |t, i| ["#{i + 1}", t] }
      Gum.table(data, columns: ['#', 'Task'], print: true, border: :rounded)
    end

    print "\n"
    print Gum.style('Press Enter to return...', foreground: '#6272A4')
    gets

  when '🗑️  Delete Task'
    if todos.empty?
      puts Gum.style('No tasks to delete 🎉', foreground: '#FFB86C')
      sleep 1.5
      next
    end

    task_to_delete = Gum.choose(todos, header: '🗑️  Choose task to delete', height: 15)

    if task_to_delete && Gum.confirm(
      "Delete this permanently?\n\n#{Gum.style(task_to_delete, bold: true)}",
      affirmative: 'Yes, delete',
      negative: 'Cancel',
      default: false,
    )
      todos.delete(task_to_delete)
      save_tasks(todos)
      puts "\n"
      puts Gum.style('🗑️  Deleted!', foreground: '#FF5555', bold: true)
    end

  when '👋  Exit'
    clear_screen
    puts Gum.style('👋  Goodbye! Keep crushing it ✨', foreground: '#FF79C6', bold: true, border: :rounded,
                                                     padding: '2 6', width: 60)
    break
  end

  next if ['📋  View Tasks', '👋  Exit'].include?(choice)

  print "\n"
  print Gum.style('Press Enter to continue...', foreground: '#6272A4')
  gets
end
