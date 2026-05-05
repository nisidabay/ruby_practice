#!/usr/bin/env ruby
# frozen_string_literal: true

# singleton_pattern.rb — exactly one instance via private_class_method :new

class Logger
  private_class_method :new

  def self.instance
    @instance ||= new
  end

  def initialize
    @logs = []
  end

  def log(message)
    entry = "[#{Time.now.strftime('%H:%M:%S')}] #{message}"
    @logs << entry
    puts entry
  end

  def logs
    @logs.dup
  end
end

logger1 = Logger.instance
logger2 = Logger.instance
puts "Same instance? #{logger1.object_id == logger2.object_id}"

logger1.log("Application started")
logger2.log("User logged in")
puts "Total logs: #{logger1.logs.length}"

