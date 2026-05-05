#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'
require 'tempfile'

# edit_file.rb — safe ~/.zshrc editor with backup and atomic replace

def edit_zshrc
  home = ENV['HOME'] || Dir.home
  path = "#{home}/.zshrc"
  backup = "#{home}/.zshrc.bak"

  unless File.exist?(path) && File.writable?(path)
    puts "Error: ~/.zshrc not found or not writable"
    exit 1
  end

  FileUtils.cp(path, backup)
  puts "Backup created at #{backup}"

  existing = File.read(path)
  puts "Current content (first 50 lines):"
  puts existing.lines.first(50).join

  puts "Enter new content (Ctrl+D to finish):"
  new = $stdin.read
  final = existing + "

" + new

  tmp = Tempfile.new(['zshrc', '.tmp'], home); tmp.close
  File.write(tmp.path, final)
  FileUtils.mv(tmp.path, path, force: true)
  puts "~/.zshrc updated successfully"
rescue StandardError => e
  puts "Error: #{e.message}. Restoring backup..."
  FileUtils.cp(backup, path) if backup
ensure
  FileUtils.rm(tmp.path) if tmp
end

edit_zshrc

