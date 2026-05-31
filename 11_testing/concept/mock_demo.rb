#!/usr/bin/env ruby
# frozen_string_literal: true

# mock_demo.rb — use Minitest::Mock to verify behavior without side effects
# This file is a demo — run it directly, not through Minitest runner.

require "minitest/autorun"

class Notifier
  def send(message)
    puts "REAL: #{message}"   # side effect: prints to terminal
  end
end

class TaskRunner
  def initialize(notifier)
    @notifier = notifier
  end

  def run
    @notifier.send("Task complete")
    "done"
  end
end

class TaskRunnerTest < Minitest::Test
  def test_notifies_on_completion
    mock = Minitest::Mock.new
    mock.expect(:send, nil, ["Task complete"])  # expect send("Task complete")

    runner = TaskRunner.new(mock)
    assert_equal "done", runner.run
    mock.verify   # fails if send("Task complete") was NOT called
  end
end
