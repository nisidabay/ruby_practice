#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Rake for Real Projects practice

require 'tmpdir'

Dir.mktmpdir('rake_exercises_') do |dir|
  Dir.mkdir("#{dir}/lib")
  Dir.mkdir("#{dir}/test")
  File.write("#{dir}/lib/calc.rb", 'module Calc; def self.add(a, b); a + b; end; end')
  File.write("#{dir}/test/calc_test.rb", <<~'TEST')
    require 'minitest/autorun'
    require_relative '../lib/calc'
    class CalcTest < Minitest::Test
      def test_add; assert_equal 5, Calc.add(2, 3); end
      def test_negative; assert_equal(-1, Calc.add(2, -3)); end
    end
  TEST

  File.write("#{dir}/Rakefile", <<~'RAKEFILE')
    require 'rake/testtask'
    require 'rake/clean'

    # Exercise 1: TestTask
    Rake::TestTask.new(:test) do |t|
      t.libs << 'lib' << 'test'
      t.test_files = FileList['test/**/*_test.rb']
      t.verbose = true
    end

    # Exercise 2: Task with arguments
    desc 'Greet someone'
    task :greet, [:name] do |t, args|
      puts "Hello, #{args[:name] || 'World'}!"
    end

    # Exercise 3: FileList
    desc 'List project files'
    task :files do
      lib = FileList['lib/**/*.rb']
      test = FileList['test/**/*.rb']
      puts "Lib: #{lib}"
      puts "Test: #{test}"
    end

    # Exercise 4: Clean
    CLEAN.include('tmp/*')
    desc 'Clean temp files'
    task :clean

    # Exercise 5: Multitask
    task :step_a do; puts 'A'; sleep 0.3; end
    task :step_b do; puts 'B'; sleep 0.3; end
    multitask parallel: [:step_a, :step_b]

    # Exercise 6: Pipeline
    desc 'Full pipeline'
    task pipeline: [:test, :files, :clean]

    task default: :test
  RAKEFILE

  puts '=== Exercise 1: rake test ==='
  system("rake -f #{dir}/Rakefile test")

  puts "\n=== Exercise 2: rake greet[Rubyist] ==="
  system("rake -f #{dir}/Rakefile 'greet[Rubyist]'")

  puts "\n=== Exercise 3: rake files ==="
  system("rake -f #{dir}/Rakefile files")

  puts "\n=== Exercise 4: rake clean ==="
  system("rake -f #{dir}/Rakefile clean")

  puts "\n=== Exercise 5: rake parallel ==="
  system("rake -f #{dir}/Rakefile parallel")

  puts "\n=== Exercise 6: rake pipeline ==="
  system("rake -f #{dir}/Rakefile pipeline")
end
