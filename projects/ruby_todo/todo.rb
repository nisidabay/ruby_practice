#!/usr/bin/env ruby
# frozen_string_literal: true

# Todo Application (Ruby version)
# Transformed from Nim implementation
# A command-line todo manager with priorities, categories, and scheduling

require 'json'
require 'fileutils'

# --- Constants ---
VERSION = '0.0.1'
SCRIPT_DIR = File.join(ENV['HOME'], 'bin', 'ruby_todos')
TODO_FILE = File.join(SCRIPT_DIR, 'todos.json')
SOUND_FILE = File.join(SCRIPT_DIR, 'bell.mp3')

# --- Priority Enum ---
# Defines priority levels for todos with associated symbols and display strings
class Priority
  VALUES = {
    high: { symbol: '🔴', display: 'high' },
    medium: { symbol: '🟡', display: 'medium' },
    low: { symbol: '✅', display: 'low' }
  }.freeze

  attr_reader :level

  # Creates a Priority instance with the specified level (defaults to :low)
  def initialize(level = :low)
    @level = VALUES.key?(level) ? level : :low
  end

  # Returns the emoji symbol for this priority level
  def symbol
    VALUES[@level][:symbol]
  end

  # Returns the display name for this priority level
  def to_s
    VALUES[@level][:display]
  end

  # Compares two Priority instances for equality
  def ==(other)
    return false unless other.is_a?(Priority)
    @level == other.level
  end

  # Allows creating Priority from a string (e.g., "high" => :high)
  def self.from_string(str)
    sym = str.downcase.to_sym
    VALUES.key?(sym) ? new(sym) : new(:low)
  end

  # Returns all valid priority levels
  def self.all_levels
    VALUES.keys
  end
end

# --- Category Enum ---
# Defines categories for organizing todos with associated symbols and display strings
class Category
  VALUES = {
    computer_language: { symbol: '💻', display: 'computer language' },
    gym: { symbol: '🏋️', display: 'gym' },
    personal: { symbol: '❤️', display: 'personal' }
  }.freeze

  attr_reader :category

  # Creates a Category instance with the specified category (defaults to :personal)
  def initialize(category = :personal)
    @category = VALUES.key?(category) ? category : :personal
  end

  # Returns the emoji symbol for this category
  def symbol
    VALUES[@category][:symbol]
  end

  # Returns the display name for this category
  def to_s
    VALUES[@category][:display]
  end

  # Compares two Category instances for equality
  def ==(other)
    return false unless other.is_a?(Category)
    @category == other.category
  end

  # Allows creating Category from a string (e.g., "gym" => :gym)
  def self.from_string(str)
    normalized = str.downcase.strip.gsub(/\s+/, '_')
    case normalized
    when 'computerlanguage', 'computer_language', 'computer'
      new(:computer_language)
    when 'gym', 'fitness'
      new(:gym)
    else
      new(:personal)
    end
  end

  # Returns all valid category types
  def self.all_categories
    VALUES.keys
  end
end

# --- Todo Item Class ---
# Represents a single todo item with all its attributes
class Todo
  attr_accessor :task, :completed, :priority, :category, :time, :sound

  # Creates a new Todo item with the specified attributes
  def initialize(task:, completed: false, priority: Priority.new, 
                 category: Category.new, time: '', sound: false)
    @task = task
    @completed = completed
    @priority = priority
    @category = category
    @time = time
    @sound = sound
  end

  # Converts the Todo item to a hash for JSON serialization
  def to_h
    {
      task: @task,
      completed: @completed,
      priority: @priority.to_s,
      category: @category.to_s,
      time: @time,
      sound: @sound
    }
  end

  # Creates a Todo item from a hash (parsed from JSON)
  def self.from_h(hash)
    Todo.new(
      task: hash['task'] || 'no task',
      completed: hash['completed'] || false,
      priority: Priority.from_string(hash['priority'] || 'low'),
      category: Category.from_string(hash['category'] || 'personal'),
      time: hash['time'] || '',
      sound: hash['sound'] || false
    )
  end

  # Returns the status string "[X]" or "[ ]" based on completion
  def status_str
    @completed ? '[X]' : '[ ]'
  end

  # Returns a formatted time string with clock emoji if time is set
  def time_str
    @time.empty? ? '' : " 🕐#{@time}"
  end

  # Returns a speaker emoji if sound is enabled
  def sound_str
    @sound ? ' 🔊' : ''
  end

  # Returns the formatted priority string with emoji
  def priority_str
    " #{@priority.symbol} #{@priority}"
  end

  # Returns the formatted category string with emoji
  def category_str
    " #{@category.symbol} #{@category}"
  end
end

# --- Todo Manager Class ---
# Manages the collection of todos with load, save, and CRUD operations
class TodoManager
  attr_reader :todos

  # Initializes the TodoManager and loads existing todos from file
  def initialize
    @todos = []
    load_todos
  end

  # Ensures the script directory exists, creates it if necessary
  def check_script_dir
    FileUtils.mkdir_p(SCRIPT_DIR) unless Dir.exist?(SCRIPT_DIR)
  rescue StandardError => e
    puts "Error: #{e.message}"
  end

  # Creates a default empty todos.json file if it doesn't exist
  def touch_todos
    return if File.exist?(TODO_FILE)

    begin
      File.write(TODO_FILE, '[]')
      puts "Created default 'todo.json' file at '#{TODO_FILE}'"
    rescue IOError => e
      puts "Warning: Could not write default 'todo.json' to '#{TODO_FILE}'"
    end
  end

  # Loads todos from the JSON file into memory
  def load_todos
    check_script_dir

    unless File.exist?(TODO_FILE)
      touch_todos
      return
    end

    begin
      data = File.read(TODO_FILE)
      if data.strip.empty?
        @todos = []
        return
      end

      json_data = JSON.parse(data)

      unless json_data.is_a?(Array)
        puts "Error loading todos: Expected a JSON array in #{TODO_FILE}"
        return
      end

      @todos = json_data.map { |node| Todo.from_h(node) }
    rescue JSON::ParserError, StandardError => e
      puts "Error loading todos: #{e.message}"
    end
  end

  # Saves all todos to the JSON file
  def save_todos
    json_data = @todos.map(&:to_h)
    File.write(TODO_FILE, JSON.pretty_generate(json_data))
  rescue StandardError => e
    puts "Error saving todos: #{e.message}"
  end

  # Displays all todos in a formatted output with status, priority, category, time, and sound
  def display_todos
    if @todos.empty?
      puts 'No todos yet! ✨'
      return
    end

    puts "\n--- Todos ---"
    @todos.each_with_index do |todo, i|
      puts "#{i + 1}. #{todo.status_str} #{todo.task}#{todo.priority_str}" \
           "#{todo.category_str}#{todo.time_str}#{todo.sound_str}"
    end
    puts '---------------'
  end

  # Adds a new todo item to the list
  def add_todo(task)
    if task.nil? || task.strip.empty?
      puts 'Cannot add an empty task.'
      return
    end

    @todos << Todo.new(task: task.strip)
    puts "Added: '#{task.strip}'"
    save_todos
    display_todos
  end

  # Lists all todos (alias for display_todos)
  def list_todos
    display_todos
  end

  # Parses a 1-indexed argument into a 0-indexed position, validates bounds
  def parse_index(arg)
    if arg.nil? || arg.strip.empty?
      puts 'Error: No todo number provided.'
      return -1
    end

    begin
      index = arg.strip.to_i - 1
      if index >= 0 && index < @todos.length
        return index
      else
        puts "Error: No todo found with number #{arg}."
        return -1
      end
    rescue StandardError
      puts "Error: '#{arg}' is not a valid number."
      return -1
    end
  end

  # Marks a todo as completed by index
  def complete_todo(index)
    return if index < 0

    if @todos[index].completed
      puts 'Task already marked as complete.'
    else
      @todos[index].completed = true
      puts "Completed: '#{@todos[index].task}'"
      save_todos
    end
    display_todos
  end

  # Removes a todo item by index
  def remove_todo(index)
    return if index < 0

    removed_task = @todos[index].task
    @todos.delete_at(index)
    puts "Removed: '#{removed_task}'"
    save_todos
    display_todos
  end

  # Edits the task description of a todo by index
  def edit_todo(index, new_task)
    return if index < 0

    if new_task.nil? || new_task.strip.empty?
      puts 'Cannot edit task with empty content.'
      return
    end

    old_task = @todos[index].task
    @todos[index].task = new_task.strip
    puts "Edited: '#{old_task}' -> '#{new_task.strip}'"
    save_todos
    display_todos
  end

  # Schedules a todo with time and optional sound notification using 'at' and 'mpv'
  def schedule_todo(index, time_str, sound)
    return false if index < 0 || index >= @todos.length

    at_cmd = `which at 2>/dev/null`.strip
    if at_cmd.empty?
      puts '❌ Error: "at" executable not found in PATH.'
      return false
    end

    player = ''
    if sound
      player = `which mpv 2>/dev/null`.strip
      if player.empty?
        puts '❌ Warning: "mpv" not found. Cannot play sound.'
        return false
      end
    end

    todo_item = @todos[index].task
    music_file = SOUND_FILE

    if sound && !File.exist?(music_file)
      puts "❌ Warning: Sound file not found: #{music_file}"
      puts "👉 Place 'bell.mp3' in #{SCRIPT_DIR}"
      return false
    end

    # Environment variables
    display = ENV['DISPLAY'] || ':0'
    dbus_address = ENV['DBUS_SESSION_BUS_ADDRESS'] || ''
    pulse_server = ENV['PULSE_SERVER'] || ''

    parts = ["export DISPLAY='#{display}'"]

    parts << "export DBUS_SESSION_BUS_ADDRESS='#{dbus_address}'" unless dbus_address.empty?
    parts << "export PULSE_SERVER='#{pulse_server}'" unless pulse_server.empty?

    # Add notification - escape single quotes in task
    escaped_task = todo_item.gsub("'", "'\"'\"'")
    parts << "notify-send -i dialog-information 'Todo Reminder' '#{escaped_task}'"

    # Add sound if requested
    if sound && File.exist?(music_file)
      parts << "#{player} --no-video --volume=70 --quiet '#{music_file}'"
    end

    full_cmd = parts.join(' && ')
    cmd = "echo '#{full_cmd}' | #{at_cmd} '#{time_str}'"

    puts "Executing: #{cmd}"
    result = system(cmd)

    if result
      @todos[index].time = time_str
      @todos[index].sound = sound
      save_todos

      puts "✅ Successfully scheduled: #{todo_item}"
      puts "🔊 With sound: #{File.basename(music_file)}" if sound
      puts "🕐 For time: #{time_str}"
      true
    else
      puts "❌ Failed to schedule todo: #{todo_item}"
      false
    end
  end

  # Sets the priority level for a todo by index
  def set_priority(index, priority)
    return if index < 0

    @todos[index].priority = Priority.from_string(priority)
    puts "Set priority '#{@todos[index].priority}' for task: '#{@todos[index].task}'"
    save_todos
    display_todos
  end

  # Sets the category for a todo by index
  def set_category(index, category)
    return if index < 0

    @todos[index].category = Category.from_string(category)
    puts "Set category '#{@todos[index].category}' for task: '#{@todos[index].task}'"
    save_todos
    display_todos
  end
end

# --- Helper Module for CLI Help ---
# Provides help text and usage instructions for the application
module TodoCLI
  # Displays the help message with all available commands and examples
  def self.show_help
    puts <<~HELP
      USAGE: todo [command] [args]  (no command = list)

      COMMANDS:
        add <task>                 done|complete <num>
        list                       rm|remove|del <num>
        edit <num> <task>          priority <num> high|medium|low
        category <num> <cat>       schedule <num> <time>
        sound <num> <time>         help

      EXAMPLES:
        todo add "Buy groceries"           # Add task
        todo priority 1 high               # Set priority (high)
        todo sound 1 "tomorrow 9:00"       # Schedule with sound
        todo done 1                        # Mark complete
        todo category 2 gym                # Set to gym
    HELP
  end

  # Parses command-line arguments and executes the corresponding action
  def self.run(manager)
    if ARGV.empty?
      manager.list_todos
      return
    end

    command = ARGV[0].downcase

    case command
    when 'add'
      if ARGV.length < 2
        puts "Error: 'add' command needs a task."
        show_help
      else
        task = ARGV[1..].join(' ')
        manager.add_todo(task)
      end

    when 'list'
      manager.list_todos

    when 'done', 'complete'
      if ARGV.length < 2
        puts "Error: 'done' command needs a todo number."
        show_help
      else
        index = manager.parse_index(ARGV[1])
        manager.complete_todo(index) unless index == -1
      end

    when 'rm', 'remove', 'del', 'delete'
      if ARGV.length < 2
        puts "Error: 'rm' command needs a todo number."
        show_help
      else
        index = manager.parse_index(ARGV[1])
        manager.remove_todo(index) unless index == -1
      end

    when 'edit'
      if ARGV.length < 3
        puts "Error: 'edit' command needs a todo number and new task."
        show_help
      else
        index = manager.parse_index(ARGV[1])
        unless index == -1
          new_task = ARGV[2..].join(' ')
          manager.edit_todo(index, new_task)
        end
      end

    when 'schedule'
      if ARGV.length < 3
        puts "Error: 'schedule' command needs a todo number and time."
        show_help
      else
        index = manager.parse_index(ARGV[1])
        unless index == -1
          time_str = ARGV[2..].join(' ')
          manager.schedule_todo(index, time_str, false)
        end
      end

    when 'sound'
      if ARGV.length < 3
        puts "Error: 'sound' command needs a todo number and time."
        show_help
      else
        index = manager.parse_index(ARGV[1])
        unless index == -1
          time_str = ARGV[2..].join(' ')
          manager.schedule_todo(index, time_str, true)
        end
      end

    when 'priority'
      if ARGV.length < 3
        puts "Error: 'priority' command needs a todo number and priority level."
        show_help
      else
        index = manager.parse_index(ARGV[1])
        unless index == -1
          priority_level = ARGV[2].downcase
          if %w[high medium low].include?(priority_level)
            manager.set_priority(index, priority_level)
          else
            puts 'Error: Priority must be one of: high, medium, low'
          end
        end
      end

    when 'category'
      if ARGV.length < 3
        puts "Error: 'category' command needs a todo number and category."
        show_help
      else
        index = manager.parse_index(ARGV[1])
        unless index == -1
          category_str = ARGV[2..].join(' ')
          manager.set_category(index, category_str)
        end
      end

    when 'help', '--help', '-h'
      show_help

    else
      puts "Unknown command: '#{command}'"
      show_help
    end
  end
end

# --- Main Program Execution ---
# Entry point: creates manager and runs CLI
if __FILE__ == $PROGRAM_NAME
  manager = TodoManager.new
  TodoCLI.run(manager)
end