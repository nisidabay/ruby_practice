#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Your Rake tasks need parameters — environment, branch, version.
# Example: `rake deploy[production,main]` — deploy to production from main branch.
#
# Solution: Task arguments with `task :name, [:arg1, :arg2] do |t, args|`.
# Visibility: Arguments are passed in brackets on the command line. No spaces inside brackets.

require 'tmpdir'

Dir.mktmpdir('rake_demo_') do |dir|
  File.write("#{dir}/Rakefile", <<~'RAKEFILE')
    desc 'Deploy to an environment from a branch'
    task :deploy, [:env, :branch] do |t, args|
      env    = args[:env] || 'staging'
      branch = args[:branch] || 'main'
      puts "Deploying to #{env} from #{branch}..."
      puts "  → git checkout #{branch}"
      puts "  → push to #{env} server"
    end

    desc 'Release a version'
    task :release, [:version] do |t, args|
      version = args[:version] || '0.1.0'
      puts "Releasing version #{version}..."
      puts "  → git tag v#{version}"
      puts "  → gem push mygem-#{version}.gem"
    end
  RAKEFILE

  puts 'Task arguments in action:'
  system("rake -f #{dir}/Rakefile deploy[production,main]")
  puts
  system("rake -f #{dir}/Rakefile release[1.2.0]")
end

# This could also be done like this:
# Environment variables (simpler, but no validation):
#
#   env = ENV['ENV'] || 'staging'
#   branch = ENV['BRANCH'] || 'main'
#   system("rake deploy ENV=production BRANCH=main")
#
# Task arguments are self-documenting (appear in rake -T) and
# validate that required args are present.
