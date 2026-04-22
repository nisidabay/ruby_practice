#!/usr/bin/env ruby
# frozen_string_literal: true

# File: filesystem_navigator.rb
# Description: A refactored Ruby script for filesystem navigation with history tracking and enhanced commands.

require 'pathname'
require 'fileutils'
require 'json'

# A class to encapsulate filesystem operations and history tracking.
class FileSystemNavigator
  attr_reader :history_file, :history

  def initialize
    @history_file = File.join(__dir__, '.fs_history.json')
    @history = load_history
  end

  def current_directory
    Dir.pwd
  end

  def list_contents
    Dir.entries('.').reject { |entry| entry.start_with?('.') }
  end

  def list_files
    Dir.glob('*').select { |entry| File.file?(entry) }
  end

  def list_directories
    Dir.glob('*').select { |entry| File.directory?(entry) }
  end

  def change_directory(path)
    Dir.chdir(path)
    log_action('cd', path)
    "Changed to: #{Dir.pwd}"
  end

  def create_directory(name)
    Dir.mkdir(name)
    log_action('mkdir', name)
    "Created directory: #{name}"
  end

  def create_nested_directories(path)
    FileUtils.mkdir_p(path)
    log_action('mkdir_p', path)
    "Created nested directories: #{path}"
  end

  def remove_directory(name)
    Dir.rmdir(name)
    log_action('rmdir', name)
    "Removed directory: #{name}"
  end

  def remove_directory_recursive(name)
    FileUtils.rm_rf(name)
    log_action('rm_rf', name)
    "Removed directory recursively: #{name}"
  end

  def create_file(path)
    FileUtils.touch(path)
    log_action('touch', path)
    "Created file: #{path}"
  end

  def read_file(path)
    File.read(path)
  end

  def remove_file(path)
    File.delete(path)
    log_action('rm', path)
    "Removed file: #{path}"
  end

  def find_files(pattern = '**/*')
    Dir.glob(pattern).select { |entry| File.file?(entry) }
  end

  def file_info(filename)
    return nil unless File.exist?(filename)

    stat = File.stat(filename)
    {
      name: filename,
      size: stat.size,
      created: stat.ctime,
      modified: stat.mtime,
      is_file: File.file?(filename),
      is_directory: File.directory?(filename),
    }
  end

  def log_action(action, path)
    timestamp = Time.now.iso8601
    @history << { 'action' => action, 'path' => path, 'timestamp' => timestamp }
    save_history
  end

  def load_history
    return [] unless File.exist?(@history_file)

    begin
      content = File.read(@history_file)
      return [] if content.strip.empty?

      data = JSON.parse(content)
      data.is_a?(Array) ? data : []
    rescue JSON::ParserError
      puts '[Debug] History file is corrupted or empty. Starting fresh.'
      []
    rescue StandardError => e
      puts "[Debug] Error loading history file: #{e.message}"
      []
    end
  end

  def save_history
    File.write(@history_file, JSON.pretty_generate(@history))
  rescue StandardError => e
    puts "[Debug] Error saving history file: #{e.message}"
  end

  def show_history
    return ['No history available.'] if @history.empty?

    ['--- Filesystem History ---'] + @history.map.with_index do |entry, index|
      "#{index + 1}. [#{entry['timestamp']}] #{entry['action']} #{entry['path']}"
    end
  end

  def clear_history
    @history.clear
    save_history
    'History cleared.'
  end
end

# --- Main execution ---

def print_help
  puts 'Filesystem Navigator - Help'
  puts 'Available commands:'
  puts '  list              - List contents of current directory'
  puts '  files             - List only files'
  puts '  dirs              - List only directories'
  puts '  cd <path>         - Change directory'
  puts '  mkdir <name>      - Create a new directory'
  puts '  mkdir_p <path>    - Create nested directories'
  puts '  rmdir <name>      - Remove empty directory'
  puts '  rm_rf <name>      - Remove directory and all contents'
  puts '  touch <file>      - Create an empty file'
  puts '  cat <file>        - Display file content'
  puts '  rm <file>         - Remove a file'
  puts "  find <pattern>    - Find files matching a pattern (e.g., '**/*.rb')"
  puts '  info <file>       - Get file information'
  puts '  history           - Show command history'
  puts '  clear_history     - Clear command history'
  puts '  help              - Show this help'
  puts '  quit, exit        - Exit the program'
end

def main_loop(navigator)
  loop do
    print '> '
    input = gets&.chomp
    break if input.nil?

    command, arg = input.split(/\s+/, 2)

    begin
      case command&.downcase
      when 'list'
        puts("Contents of #{navigator.current_directory}:", navigator.list_contents.map { |e| "  #{e}" })
      when 'files'
        puts("Files in #{navigator.current_directory}:", navigator.list_files.map { |f| "  #{f}" })
      when 'dirs'
        puts("Directories in #{navigator.current_directory}:", navigator.list_directories.map { |d| "  #{d}" })
      when 'history'
        puts navigator.show_history
      when 'clear_history'
        puts navigator.clear_history
      when 'help'
        print_help
      when 'quit', 'exit'
        puts 'Goodbye!'
        break
      when 'cd'
        arg ? (puts navigator.change_directory(arg)) : (puts 'Usage: cd <path>')
      when 'mkdir'
        arg ? (puts navigator.create_directory(arg)) : (puts 'Usage: mkdir <name>')
      when 'mkdir_p'
        arg ? (puts navigator.create_nested_directories(arg)) : (puts 'Usage: mkdir_p <path>')
      when 'rmdir'
        arg ? (puts navigator.remove_directory(arg)) : (puts 'Usage: rmdir <name>')
      when 'rm_rf'
        arg ? (puts navigator.remove_directory_recursive(arg)) : (puts 'Usage: rm_rf <name>')
      when 'touch'
        arg ? (puts navigator.create_file(arg)) : (puts 'Usage: touch <file>')
      when 'cat'
        arg ? (puts navigator.read_file(arg)) : (puts 'Usage: cat <file>')
      when 'rm'
        arg ? (puts navigator.remove_file(arg)) : (puts 'Usage: rm <file>')
      when 'find'
        pattern = arg || '**/*'
        files = navigator.find_files(pattern)
        puts("Found files matching '#{pattern}':", files.map { |f| "  #{f}" })
      when 'info'
        if arg
          info = navigator.file_info(arg)
          info ? puts("File info for '#{arg}':", info.map { |k, v| "  #{k}: #{v}" }) : (puts "File not found: #{arg}")
        else
          puts 'Usage: info <file>'
        end
      when nil
        # User just pressed Enter
      else
        puts "Unknown command: #{command}. Type 'help' for available commands."
      end
    rescue SystemCallError => e
      puts "Error: #{e.message}"
    rescue StandardError => e
      puts "An unexpected error occurred: #{e.class} - #{e.message}"
    end
  end
end

if __FILE__ == $0
  navigator = FileSystemNavigator.new

  puts "Filesystem Navigator - Current Directory: #{navigator.current_directory}"
  print_help
  puts ''

  main_loop(navigator)
end
