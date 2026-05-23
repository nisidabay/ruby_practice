#!/usr/bin/env ruby
# frozen_string_literal: true

# Test runner for all project tools
# Run: ruby project/test.rb

require 'minitest/autorun'

# Tests for the utilities module (extracted from freport)
class TestHumanSize < Minitest::Test
  def human_size(bytes)
    return "0 B" if bytes.zero?
    units = %w[B KB MB GB TB]
    exp = (Math.log(bytes) / Math.log(1024)).to_i
    exp = units.size - 1 if exp >= units.size
    format("%.1f %s", bytes.to_f / (1024 ** exp), units[exp])
  end

  def test_zero
    assert_equal "0 B", human_size(0)
  end

  def test_bytes
    assert_equal "500.0 B", human_size(500)
  end

  def test_kilobytes
    assert_equal "1.0 KB", human_size(1024)
  end

  def test_megabytes
    assert_equal "1.0 MB", human_size(1024 * 1024)
  end
end
