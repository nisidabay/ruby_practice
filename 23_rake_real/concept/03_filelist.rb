#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Select files for a task — all .rb files in lib/, but not in test/.
# Example: A build task that needs every Ruby file except tests.
#
# Solution: Rake::FileList — glob patterns with exclusion rules.
# Visibility: `FileList['lib/**/*.rb']` returns an array-like object you can filter.

require 'tmpdir'

Dir.mktmpdir('rake_demo_') do |dir|
  # Create a fake project structure
  FileUtils.mkdir_p("#{dir}/lib")
  FileUtils.mkdir_p("#{dir}/test")
  File.write("#{dir}/lib/app.rb", '# main app')
  File.write("#{dir}/lib/helper.rb", '# helper')
  File.write("#{dir}/test/app_test.rb", '# test')
  File.write("#{dir}/Rakefile", <<~'RAKEFILE')
    desc 'Show project files'
    task :files do
      # All Ruby files
      all = FileList['**/*.rb']
      puts "All .rb files (#{all.size}):"
      all.each { |f| puts "  #{f}" }

      # Only lib files, exclude test
      lib = FileList['lib/**/*.rb']
      puts "\nLib files only (#{lib.size}):"
      lib.each { |f| puts "  #{f}" }

      # Exclude patterns
      no_test = FileList['**/*.rb'].exclude('test/**/*')
      puts "\nExcluding test/ (#{no_test.size}):"
      no_test.each { |f| puts "  #{f}" }
    end
  RAKEFILE

  system("rake -f #{dir}/Rakefile files")
end

# This could also be done like this:
# Dir.glob (works, but no exclude method):
#
#   Dir.glob('**/*.rb')  # all files
#   Dir.glob('lib/**/*.rb')  # lib only
#
# FileList adds .exclude, .include, .sub, and integrates with
# Rake's file task resolution.
