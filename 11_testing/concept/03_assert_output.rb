#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_assert_output.rb — assert_output: test what gets printed to stdout/stderr
#
# WITHOUT assert_output — you redirect $stdout manually:
#
#   old = $stdout; $stdout = StringIO.new; do_thing; output = $stdout.string; $stdout = old
#   # easy to forget restore, verbose
#
# WITH assert_output — Minitest handles the redirect:

require "minitest/autorun"

def greet(name)
  puts "Hello, #{name}!"
end

def warn_deploy(env)
  warn "WARNING: deploying to #{env}" if env == "production"
end

class OutputTest < Minitest::Test
  def test_greet_prints_to_stdout
    assert_output("Hello, Carlos!\n") do
      greet("Carlos")
    end
  end

  def test_greet_matches_pattern
    assert_output(/Hello,/) do
      greet("Ana")
    end
  end

  def test_warn_goes_to_stderr
    assert_output(nil, /WARNING/) do  # nil = don't check stdout
      warn_deploy("production")
    end
  end

  def test_no_output_on_safe_env
    assert_silent do  # no stdout AND no stderr
      warn_deploy("staging")
    end
  end
end

# assert_output(stdout = '', stderr = '')
# assert_silent — no output to either stream

# Thinking in Ruby
#
# assert_output captures Ruby's free-flowing output streams without
# manual $stdout redirects. It accepts string literals or regex
# patterns, and separates stdout from stderr. assert_silent goes
# further — it fails if either stream produces anything at all.
