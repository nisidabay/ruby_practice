#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: CI/CD needs a single command that runs everything in order, failing fast.
# Example: `rake ci` runs test → lint → build → package. If test fails, nothing else runs.
#
# Solution: Chain tasks with dependencies. Rake stops at the first failure.
# Visibility: `task ci: [:test, :lint, :build, :package]` — each depends on the previous.

require 'tmpdir'

Dir.mktmpdir('rake_demo_') do |dir|
  Dir.mkdir("#{dir}/lib")
  Dir.mkdir("#{dir}/test")
  File.write("#{dir}/lib/app.rb", 'class App; end')
  File.write("#{dir}/test/app_test.rb", <<~'TEST')
    require 'minitest/autorun'
    class AppTest < Minitest::Test
      def test_truth; assert true; end
    end
  TEST

  File.write("#{dir}/Rakefile", <<~'RAKEFILE')
    require 'rake/testtask'
    require 'rake/clean'
    require 'rake/packagetask'

    # ── Stage 1: Test ──────────────────────────────────────────
    Rake::TestTask.new(:test) do |t|
      t.libs << 'lib' << 'test'
      t.test_files = FileList['test/**/*_test.rb']
    end

    # ── Stage 2: Lint ──────────────────────────────────────────
    task :lint do
      puts 'Linting...'
      # sh 'rubocop lib/'  # uncomment in real project
      puts '  ✓ No issues (rubocop not installed — skipping)'
    end

    # ── Stage 3: Build ────────────────────────────────────────
    CLEAN.include('build/')
    directory 'build'
    task build: ['build'] do
      cp_r 'lib', 'build/'
      puts "  ✓ Build: #{Dir['build/**/*'].size} files"
    end

    # ── Stage 4: Package ───────────────────────────────────────
    Rake::PackageTask.new('mygem', '0.1.0') do |p|
      p.need_tar_gz = true
      p.package_files = FileList['lib/**/*.rb']
    end

    # ── CI Pipeline ────────────────────────────────────────────
    desc 'CI pipeline: test → lint → build → package'
    task ci: [:test, :lint, :build, :package]

    task default: :ci
  RAKEFILE

  puts 'CI pipeline in action:'
  system("rake -f #{dir}/Rakefile ci")
  puts
  puts 'Generated package:'
  system("ls #{dir}/pkg/")
end

# This could also be done like this:
# Shell script (works, but no per-stage reporting):
#
#   #!/bin/bash
#   ruby -Ilib:test test/**/*_test.rb || exit 1
#   rubocop lib/ || exit 1
#   gem build mygem.gemspec
#
# Rake gives you: `rake -T` to see the pipeline, per-task timing,
# and the ability to run individual stages (`rake test` only).
