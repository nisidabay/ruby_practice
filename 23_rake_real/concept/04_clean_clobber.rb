#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Your project generates temp files — builds, caches, logs. You need to clean them.
# Example: `rake clean` removes build/, `rake clobber` removes build/ AND packaged gems.
#
# Solution: Rake's clean/clobber pattern — two levels of cleanup.
# Visibility: Define CLEAN and CLOBBER file lists, Rake does the rest.

require 'tmpdir'

Dir.mktmpdir('rake_demo_') do |dir|
  # Create fake build artifacts
  Dir.mkdir("#{dir}/build")
  File.write("#{dir}/build/output.o", 'object')
  File.write("#{dir}/build/cache.tmp", 'cache')
  File.write("#{dir}/mygem-0.1.0.gem", 'gem')

  File.write("#{dir}/Rakefile", <<~'RAKEFILE')
    require 'rake/clean'

    # CLEAN — temporary files, rebuildable
    CLEAN.include('build/*.o', 'build/*.tmp', '*.log')

    # CLOBBER — everything, including packaged artifacts
    CLOBBER.include('*.gem', 'pkg/')

    desc 'Remove temporary build files'
    task :clean

    desc 'Remove ALL generated files (including packages)'
    task :clobber

    desc 'Show what would be cleaned'
    task :preview do
      puts "CLEAN would remove: #{CLEAN}"
      puts "CLOBBER would remove: #{CLOBBER}"
    end
  RAKEFILE

  puts 'Before:'
  system("ls #{dir}/build/ #{dir}/*.gem 2>/dev/null")
  puts

  system("rake -f #{dir}/Rakefile clean")
  puts 'After clean:'
  system("ls #{dir}/build/ #{dir}/*.gem 2>/dev/null")
end

# This could also be done like this:
# Manual cleanup (works, but no standard pattern):
#
#   task :clean do
#     rm_rf 'build'
#     rm_f Dir.glob('*.log')
#   end
#
# CLEAN/CLOBBER is the Rails convention — every Ruby dev knows it.
