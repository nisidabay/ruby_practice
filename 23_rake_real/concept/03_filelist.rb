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
#
# Thinking in Ruby
#
# Rake::FileList extends the standard Dir.glob with chainable filtering methods
# (.exclude, .include), giving build scripts the power of glob patterns with the
# composability of method chaining. This is a distinctly Ruby approach: instead
# of a separate template or DSL for file selection, FileList is an array-like
# object you can query, filter, and transform using familiar Ruby methods. It
# bridges the gap between simple globs and custom file selection logic.
