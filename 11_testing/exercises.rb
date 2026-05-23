#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Write a test
require 'minitest/autorun'

class TestFileUtils < Minitest::Test
  def test_file_exists
    # --- your code here ---
    # HINT: assert File.exist?("project/test.rb")
  end

  def test_size_positive
    # HINT: assert File.size("project/test.rb") > 0
  end

  def test_directory
    # HINT: assert File.directory?("project/")
  end
end
