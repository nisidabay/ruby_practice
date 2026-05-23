#!/usr/bin/env ruby
# frozen_string_literal: true
# Todo List Manager
# This file implements a todo list management system.
# Demonstrates array manipulation and basic CRUD operations.


# Made with grok
# ────────────────────────────────────────────────
# Single-file Todo List CLI App
# No folders or separate files required
# ────────────────────────────────────────────────

class Task
  attr_reader :description, :done

  def initialize(description)
    @description = description.strip
    @done = false
  end

  def mark_done!
    @done = true
  end

  def done?
    @done
  end

  def to_s
    marker = done? ? '[x]' : '[ ]'
    "#{marker} #{@description}"
  end
end

# ────────────────────────────────────────────────

class TodoList
  attr_reader :tasks

  def initialize(tasks = [])
    @tasks = tasks
  end

  def add(task)
    @tasks << task
  end

  def mark_done(index)
    @tasks[index]&.mark_done!
  end

  def delete(index)
    @tasks.delete_at(index) if valid_index?(index)
  end

  def valid_index?(index)
    index >= 0 && index < @tasks.length
  end
end

# ────────────────────────────────────────────────

class FileStorage
  def initialize(file_path = 'todo_list.txt')
    @file_path = file_path
  end

  def load
    return TodoList.new unless File.exist?(@file_path)

    lines = File.readlines(@file_path, chomp: true)
    tasks = lines.map do |line|
      next if line.strip.empty?

      done = line.start_with?('[x]')
      desc = line.sub(/^\[(x| )\]\s*/, '').strip
      task = Task.new(desc)
      task.mark_done! if done
      task
    end.compact

    TodoList.new(tasks)
  rescue StandardError => e
    warn "Could not load tasks: #{e.message}"
    TodoList.new
  end

  def save(todo_list)
    File.write(@file_path, todo_list.tasks.map(&:to_s).join("\n") + "\n")
  rescue StandardError => e
    warn "Could not save tasks: #{e.message}"
  end
end

# ────────────────────────────────────────────────

class ConsoleView
  def display_menu
    begin
      system('clear') || system('cls')
    rescue StandardError
      nil
    end # try to clear screen

    puts "\n" * 2
    puts '  ╔════════════════════════════════════╗'
    puts '  ║          Todo List Manager         ║'
    puts '  ╚════════════════════════════════════╝'
    puts '  Commands:'
    puts '    add       → Add new task'
    puts '    list      → Show all tasks'
    puts '    mark_done → Mark task as done'
    puts '    delete    → Remove a task'
    puts '    exit / q  → Save and quit'
    puts '  ═══════════════════════════════════════'
  end

  def display_tasks(tasks)
    if tasks.empty?
      puts "\n  No tasks yet — time to add some!\n"
      return
    end

    puts "\n  Your tasks:"
    tasks.each_with_index do |task, i|
      puts "  #{i + 1}. #{task}"
    end
    puts
  end

  def get_task_description
    print '  Describe the task: '
    gets&.chomp&.strip.to_s
  end

  def get_task_index(prompt = '  Task number (1-based): ')
    print prompt
    input = gets&.chomp&.strip
    begin
      Integer(input)
    rescue StandardError
      nil
    end
  end

  def display_task_added(task)
    puts "  → Added: #{task}"
  end

  def display_task_marked_done(number)
    puts "  → Task ##{number} marked as done ✓"
  end

  def display_task_deleted(task)
    puts "  → Deleted: #{task}" if task
  end

  def display_invalid_input
    puts '  Unknown command — try again.'
  end

  def display_invalid_index
    puts '  Invalid task number.'
  end
end

# ────────────────────────────────────────────────

class TodoApp
  def initialize(file_path = 'todo_list.txt')
    @storage = FileStorage.new(file_path)
    @list    = @storage.load
    @view    = ConsoleView.new
  end

  def run
    loop do
      @view.display_menu
      @view.display_tasks(@list.tasks)

      print '  → '
      cmd = gets&.chomp&.strip&.downcase

      case cmd
      when 'add'       then add_task
      when 'list'      then next # just refresh
      when 'mark_done' then mark_task_done
      when 'delete'    then delete_task
      when 'exit', 'q', '' then break
      else
        @view.display_invalid_input
        sleep 1.2
      end
    end

    @storage.save(@list)
    puts "\n  Tasks saved. See you next time!\n\n"
  end

  private

  def add_task
    desc = @view.get_task_description
    return if desc.empty?

    task = Task.new(desc)
    @list.add(task)
    @view.display_task_added(task)
  end

  def mark_task_done
    return if @list.tasks.empty?

    num = @view.get_task_index
    return unless num

    idx = num - 1
    if @list.valid_index?(idx)
      @list.mark_done(idx)
      @view.display_task_marked_done(num)
    else
      @view.display_invalid_index
    end
  end

  def delete_task
    return if @list.tasks.empty?

    num = @view.get_task_index
    return unless num

    idx = num - 1
    if @list.valid_index?(idx)
      deleted = @list.delete(idx)
      @view.display_task_deleted(deleted)
    else
      @view.display_invalid_index
    end
  end
end

# ────────────────────────────────────────────────
# Start the application
# ────────────────────────────────────────────────

if __FILE__ == $PROGRAM_NAME
  app = TodoApp.new('todo_list.txt')
  app.run
end
