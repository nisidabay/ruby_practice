#!/usr/bin/env ruby
# frozen_string_literal: true

# Ruby File Formatter
# This script applies consistent Ruby formatting standards to all Ruby files

# Basic Ruby formatting standards
RUBY_STANDARDS = {
  shebang: '#!/usr/bin/env ruby',
  frozen_string_literal: '# frozen_string_literal: true',
}.freeze

def format_ruby_file(file_path)
  puts "Formatting: #{file_path}"

  # Read the original content
  content = File.read(file_path)

  # Check and add shebang if missing but file contains executable content
  if File.executable?(file_path) && !content.start_with?(RUBY_STANDARDS[:shebang])
    content = "#{RUBY_STANDARDS[:shebang]}\n#{content}"
  end

  # Ensure frozen_string_literal comment is present
  unless content.include?(RUBY_STANDARDS[:frozen_string_literal])
    lines = content.lines
    if content.start_with?(RUBY_STANDARDS[:shebang])
      lines.insert(1, "#{RUBY_STANDARDS[:frozen_string_literal]}\n")
    else
      lines.insert(0, "#{RUBY_STANDARDS[:frozen_string_literal]}\n")
    end
    content = lines.join
  end

  # Basic cleanup: remove trailing whitespace
  content.gsub!(/[ \t]+\n/, "\n")

  # Write back the formatted content
  File.write(file_path, content)

  puts "✓ Formatted: #{file_path}"
end

def find_ruby_files(directory = '.')
  ruby_files = []

  Dir.glob(File.join(directory, '**', '*.rb')) do |file|
    # Skip backup folder
    next if file.include?('ruby_backup/')

    ruby_files << file
  end

  ruby_files
end

def main
  puts 'Ruby File Formatter'
  puts '=' * 40

  ruby_files = find_ruby_files

  puts "Found #{ruby_files.size} Ruby files to format"
  puts '=' * 40

  ruby_files.each do |file_path|

    format_ruby_file(file_path)
  rescue StandardError => e
    puts "⚠ Error formatting #{file_path}: #{e.message}"

  end

  puts '=' * 40
  puts 'Formatting completed!'
end

if $PROGRAM_NAME == __FILE__
  main
end
