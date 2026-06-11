#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want `rake test` to run your Minitest suite — one command, no flags.
# Example: `rake test` runs all tests in test/, with verbose output.
#
# Solution: Rake::TestTask — built-in task that finds and runs tests.
# Visibility: `require 'rake/testtask'`. Define it once, run `rake test` forever.

require 'tmpdir'

Dir.mktmpdir('rake_demo_') do |dir|
  # Create a test file
  Dir.mkdir("#{dir}/test")
  File.write("#{dir}/test/demo_test.rb", <<~'TEST')
    require 'minitest/autorun'

    class DemoTest < Minitest::Test
      def test_addition
        assert_equal 4, 2 + 2
      end

      def test_string
        assert_equal 'HELLO', 'hello'.upcase
      end

      def test_skip
        skip 'not implemented yet'
      end
    end
  TEST

  File.write("#{dir}/Rakefile", <<~'RAKEFILE')
    require 'rake/testtask'

    Rake::TestTask.new do |t|
      t.libs << 'test'
      t.test_files = FileList['test/**/*_test.rb']
      t.verbose = true
    end

    task default: :test
  RAKEFILE

  puts 'Rake::TestTask in action:'
  system("rake -f #{dir}/Rakefile test")
end

# This could also be done like this:
# Running Minitest directly (works, but no rake integration):
#
#   ruby -Ilib:test test/**/*_test.rb
#
# Rake::TestTask gives you: `rake test` (muscle memory),
# `rake test TEST=test/demo_test.rb` (run one file),
# `rake test TESTOPTS='--verbose'` (pass options).
