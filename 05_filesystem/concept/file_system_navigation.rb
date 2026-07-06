#!/usr/bin/env ruby
# frozen_string_literal: true

# file_system_navigation.rb — interactive filesystem navigator

require 'pathname'
require 'fileutils'
require 'json'

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
    Dir.entries('.').reject { |e| e.start_with?('.') }
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
    "Created nested: #{path}"
  end

  def remove_directory(name)
    Dir.rmdir(name)
    log_action('rmdir', name)
    "Removed: #{name}"
  end

  def remove_directory_recursive(name)
    FileUtils.rm_rf(name)
    log_action('rm_rf', name)
    "Removed recursively: #{name}"
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
    Dir.glob(pattern).select { |e| File.file?(e) }
  end

  def file_info(filename)
    return nil unless File.exist?(filename)
    stat = File.stat(filename)
    { name: filename, size: stat.size, created: stat.ctime,
      modified: stat.mtime, type: File.directory?(filename) ? 'dir' : 'file' }
  end

  def show_history
    return ['No history.'] if @history.empty?
    @history.map.with_index { |e, i| "#{i + 1}. [#{e['timestamp']}] #{e['action']} #{e['path']}" }
  end

  def clear_history
    @history.clear
    save_history
    'History cleared.'
  end

  private

  def log_action(action, path)
    @history << { 'action' => action, 'path' => path, 'timestamp' => Time.now.iso8601 }
    save_history
  end

  def load_history
    return [] unless File.exist?(@history_file)
    begin
      data = JSON.parse(File.read(@history_file))
      data.is_a?(Array) ? data : []
    rescue JSON::ParserError, StandardError
      []
    end
  end

  def save_history
    File.write(@history_file, JSON.pretty_generate(@history))
  rescue StandardError
    nil
  end
end

# --- Interactive loop ---

def run
  nav = FileSystemNavigator.new

  puts "Filesystem Navigator"
  puts "Commands: list, cd, mkdir, mkdir_p, rmdir, touch, cat, rm, find, info, history, clear_history, help, quit"

  loop do
    print '> '
    input = gets&.chomp
    break if input.nil? || %w[quit exit].include?(input.downcase)

    cmd, arg = input.split(/\s+/, 2)
    begin
      case cmd
      when 'list'     then puts nav.list_contents
      when 'cd'       then puts arg ? nav.change_directory(arg) : "Usage: cd <path>"
      when 'mkdir'    then puts arg ? nav.create_directory(arg) : "Usage: mkdir <name>"
      when 'mkdir_p'  then puts arg ? nav.create_nested_directories(arg) : "Usage: mkdir_p <path>"
      when 'rmdir'    then puts arg ? nav.remove_directory(arg) : "Usage: rmdir <name>"
      when 'touch'    then puts arg ? nav.create_file(arg) : "Usage: touch <file>"
      when 'cat'      then puts arg ? nav.read_file(arg) : "Usage: cat <file>"
      when 'rm'       then puts arg ? nav.remove_file(arg) : "Usage: rm <file>"
      when 'find'     then puts nav.find_files(arg || '**/*')
      when 'info'     then puts arg ? nav.file_info(arg) : "Usage: info <file>"
      when 'history'  then puts nav.show_history
      when 'clear_history' then puts nav.clear_history
      when 'help'     then puts "Commands: list, cd, mkdir, mkdir_p, rmdir, touch, cat, rm, find, info, history, clear_history, help, quit"
      end
    rescue SystemCallError => e
      puts "Error: #{e.message}"
    end
  end

  puts 'Goodbye!'
end

run if __FILE__ == $0

# Thinking in Ruby
#
# file_system_navigation.rb is an interactive REPL built with Ruby's
# standard library — no gems. It demonstrates Pathname, FileUtils, JSON
# persistence, Dir operations, and SystemCallError handling in a single
# class. The `__FILE__ == $0` pattern at the end means the file works
# as both a library (require) and a standalone script (run it directly).
# Ruby's design enables this dual-purpose pattern naturally.

