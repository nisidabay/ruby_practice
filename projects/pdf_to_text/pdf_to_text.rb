#!/usr/bin/env ruby

require 'pdf-reader'
require 'fileutils'

def pdf_to_text(pdf_path, output_dir = 'extracted_text')
  FileUtils.mkdir_p(output_dir)

  reader = PDF::Reader.new(pdf_path)
  basename = File.basename(pdf_path, '.pdf')
  output_file = File.join(output_dir, "#{basename}.md")

  File.open(output_file, 'w') do |f|
    f.puts "# #{basename}\n\n"

    reader.pages.each_with_index do |page, index|
      f.puts "\n---\n\n## Page #{index + 1}\n\n"
      f.puts page.text
    end
  end

  puts "Extracted: #{pdf_path} -> #{output_file}"
rescue StandardError => e
  puts "Error processing #{pdf_path}: #{e.message}"
end

if __FILE__ == $0
  if ARGV.empty?
    puts 'Usage: ruby pdf_to_text.rb <pdf_files...>'
    puts '       ruby pdf_to_text.rb *.pdf'
    exit 1
  end

  ARGV.each do |pdf_file|
    pdf_to_text(pdf_file) if File.extname(pdf_file).downcase == '.pdf'
  end
end
