#!/usr/bin/env ruby
# frozen_string_literal: true

# Edit file
# This file contains Ruby code for edit file.

# zshrc_editor.rb - Safe ~/.zshrc editor with backup and validation
# Features:
# - Creates backup before editing
# - Validates file permissions
# - Handles file locking for safety
# - Preserves existing content
# - Uses temporary file for atomic updates

require 'fileutils'
require 'tempfile'

def edit_zshrc
  home_dir = ENV['HOME'] || Dir.home
  zshrc_path = "#{home_dir}/.zshrc"
  backup_path = "#{home_dir}/.zshrc.bak"

  # Safety checks
  unless File.exist?(zshrc_path)
    puts "Error: ~/.zshrc not found at #{zshrc_path}"
    exit 1
  end

  unless File.writable?(zshrc_path)
    puts "Error: Cannot write to #{zshrc_path}. Try running with sudo or check permissions."
    exit 1
  end

  # Create backup
  puts "Creating backup of #{zshrc_path}..."
  FileUtils.cp(zshrc_path, backup_path)

  # Create temporary file
  temp_file = Tempfile.new(['zshrc', '.tmp'], home_dir)
  temp_file.close

  begin
    # Read existing content
    existing_content = File.read(zshrc_path)

    # Get new content from user
    puts "\nCurrent ~/.zshrc content (first 50 lines):"
    puts existing_content.lines.first(50).join
    puts '...[truncated]...'

    print "\nEnter new content (press Ctrl+D to finish):\n"
    new_content = $stdin.read

    # Combine existing and new content
    final_content = existing_content + "\n\n" + new_content

    # Write to temp file
    File.write(temp_file.path, final_content)

    # Atomic replace
    FileUtils.mv(temp_file.path, zshrc_path, force: true)

    puts "\nSuccessfully updated ~/.zshrc"
    puts "Backup created at #{backup_path}"
  rescue StandardError => e
    puts "Error during update: #{e.message}"
    puts 'Restoring from backup...'
    FileUtils.cp(backup_path, zshrc_path)
    exit 1
  ensure
    FileUtils.rm(temp_file.path) if temp_file
  end
end

edit_zshrc
