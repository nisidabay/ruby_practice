#!/usr/bin/env ruby
# frozen_string_literal: true

# Recursively delete a directory
def delete_directory(path)
  return unless Dir.exist?(path)

  Dir.children(path).each do |name|
    full_path = File.join(path, name)

    if File.directory?(full_path)
      delete_directory(full_path)
    else
      File.delete(full_path)
    end
  end
  Dir.delete(path)
end

folder = 'vacation_2026'
delete_directory(folder)
