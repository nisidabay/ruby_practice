#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Every Ruby project needs the same tasks: test, build, lint, clean, release.
# Example: A Rakefile you can copy to any project and it just works.
#
# Solution: A complete, production-ready Rakefile with all standard tasks.
# Visibility: Copy this to your project root. Run `rake -T` to see all tasks.

require 'tmpdir'

Dir.mktmpdir('rake_demo_') do |dir|
  # Create a realistic project structure
  Dir.mkdir("#{dir}/lib")
  Dir.mkdir("#{dir}/test")
  File.write("#{dir}/lib/app.rb", 'class App; end')
  File.write("#{dir}/test/app_test.rb", <<~'TEST')
    require 'minitest/autorun'
    require_relative '../lib/app'

    class AppTest < Minitest::Test
      def test_exists
        assert App
      end
    end
  TEST

  File.write("#{dir}/Rakefile", <<~'RAKEFILE')
    require 'rake/testtask'
    require 'rake/clean'

    # ── Test ──────────────────────────────────────────────────
    Rake::TestTask.new(:test) do |t|
      t.libs << 'lib' << 'test'
      t.test_files = FileList['test/**/*_test.rb']
      t.verbose = true
    end

    # ── Lint ──────────────────────────────────────────────────
    desc 'Run RuboCop (if installed)'
    task :lint do
      if system('which rubocop > /dev/null 2>&1')
        sh 'rubocop lib/'
      else
        puts 'RuboCop not installed — skipping lint.'
        puts 'Install with: gem install rubocop'
      end
    end

    # ── Build ─────────────────────────────────────────────────
    CLEAN.include('build/')
    directory 'build'

    desc 'Build project (run tests first)'
    task build: [:test, 'build'] do
      cp_r 'lib', 'build/'
      puts "Build complete: #{Dir['build/**/*'].size} files"
    end

    # ── Release ───────────────────────────────────────────────
    CLOBBER.include('pkg/')

    desc 'Release: test → lint → build → package'
    task release: [:test, :lint, :build] do
      version = ENV['VERSION'] || '0.1.0'
      puts "Releasing version #{version}..."
      puts '  → git tag v' + version
      puts '  → gem push mygem-' + version + '.gem'
    end

    # ── Default ───────────────────────────────────────────────
    task default: :test
  RAKEFILE

  puts 'Available tasks:'
  system("rake -f #{dir}/Rakefile -T")
  puts
  puts 'Running tests:'
  system("rake -f #{dir}/Rakefile test")
end

# This could also be done like this:
# Separate scripts for each task (no dependency management):
#
#   ruby test_runner.rb
#   ruby build.rb
#   ruby release.rb
#
# A Rakefile centralizes everything — `rake -T` shows all tasks,
# dependencies are explicit, and it's the Ruby community standard.
#
# Thinking in Ruby
#
# A well-structured Rakefile is the Ruby equivalent of a Makefile — it centralizes
# all project tasks into a single, runnable file. The convention of `rake -T` for
# listing tasks, `task default: :test` for common commands, and dependency chains
# for multi-step workflows creates a universal interface that every Ruby developer
# understands. This Rakefile template can bootstrap any new Ruby project with
# test, lint, build, and release tasks in minutes.
