#!/usr/bin/env ruby
# frozen_string_literal: true

# 04_setup_teardown.rb — setup/teardown: shared state across test methods
#
# WITHOUT setup — repeat initialization in every test:
#
#   def test_one
#     @user = User.new("Alice", "alice@dev.io")  # duplicated in test_two, test_three
#   end
#
# WITH setup — Minitest runs it before EVERY test:

require "minitest/autorun"
require "tmpdir"

class TempStorage
  def initialize(dir); @dir = dir; end

  def write(filename, content)
    File.write(File.join(@dir, filename), content)
  end

  def read(filename)
    File.read(File.join(@dir, filename))
  end
end

class TempStorageTest < Minitest::Test
  def setup
    # Runs before EACH test — fresh state every time
    @tmpdir = Dir.mktmpdir
    @storage = TempStorage.new(@tmpdir)
  end

  def teardown
    # Runs after EACH test — cleanup even if test fails
    FileUtils.rm_rf(@tmpdir) if @tmpdir
  end

  def test_write_and_read
    @storage.write("data.txt", "hello")
    assert_equal "hello", @storage.read("data.txt")
  end

  def test_write_overwrites
    @storage.write("data.txt", "first")
    @storage.write("data.txt", "second")
    assert_equal "second", @storage.read("data.txt")
  end

  # Each test gets its OWN tmpdir — tests never interfere.
  # setup/teardown isolate them completely.
end

# before_all / after_all: use class-level methods (runs once)
# Minitest doesn't have them built-in — use Minitest::Test class methods
# or the minitest-hooks gem.
