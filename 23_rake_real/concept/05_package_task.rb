#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Package your gem for distribution — .gem file and .tar.gz.
# Example: `rake package` creates mygem-0.1.0.gem and mygem-0.1.0.tar.gz.
#
# Solution: Rake::PackageTask — builds gem and tarball from your project files.
# Visibility: `require 'rake/packagetask'`. Define once, get two formats.

require 'tmpdir'

Dir.mktmpdir('rake_demo_') do |dir|
  # Create a minimal gem structure
  Dir.mkdir("#{dir}/lib")
  File.write("#{dir}/lib/mygem.rb", 'module Mygem; VERSION = "0.1.0"; end')

  File.write("#{dir}/Rakefile", <<~'RAKEFILE')
    require 'rake/packagetask'

    Rake::PackageTask.new('mygem', '0.1.0') do |p|
      p.need_tar_gz = true
      p.package_files = FileList['lib/**/*.rb', 'README.md']
    end

    desc 'Package gem and tarball'
    task :package
  RAKEFILE

  puts 'Rake::PackageTask in action:'
  system("rake -f #{dir}/Rakefile package")
  puts
  puts 'Generated files:'
  system("ls -lh #{dir}/pkg/")
end

# This could also be done like this:
# Manual gem build (works, but no tarball):
#
#   task :package do
#     sh 'gem build mygem.gemspec'
#   end
#
# PackageTask gives you .gem AND .tar.gz in one command.
# The tarball is useful for non-Ruby users or system packages.
#
# Thinking in Ruby
#
# Rake::PackageTask demonstrates Ruby's awareness of the broader ecosystem:
# packaging goes beyond gem files. By generating both .gem and .tar.gz formats
# from a single definition, Rake acknowledges that Ruby libraries may be consumed
# by system package managers (apt, yum) or non-Ruby tools. The convention of
# packaging into a `pkg/` directory is another community standard that Rake
# codifies — every Ruby developer knows where to find build artifacts.
