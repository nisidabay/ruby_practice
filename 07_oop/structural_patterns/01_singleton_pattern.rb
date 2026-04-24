#!/usr/bin/env ruby

# Problem: You need exactly one instance of a class (e.g., database connection, configuration, logger).
# Example: A Logger that all parts of your app use - only one should exist to share the log history.
#
# Solution: Use the singleton pattern - private constructor + class method to access the single instance.
# Visibility: Instance is globally accessible via .instance, constructor is private.

class Logger
  private_class_method :new

  def self.instance
    @instance ||= new
  end

  def initialize
    @logs = []
  end

  def log(message)
    entry = "[#{Time.now.strftime("%H:%M:%S")}] #{message}"
    @logs << entry
    puts entry
  end

  def logs
    @logs.dup
  end
end

# Usage: Get the single instance via .instance
logger1 = Logger.instance
logger2 = Logger.instance

puts "Same instance? #{logger1.object_id == logger2.object_id}"

logger1.log("Application started")
logger2.log("User logged in")

puts "\nTotal logs: #{logger1.logs.length}"

# This could also be done like this:
# For configuration, use a module with module-level variables:
#
# module Config
#   def self.[](key)
#     @settings[key]
#   end
#
#   def self.[]=(key, value)
#     @settings ||= {}
#     @settings[key] = value
#   end
# end
#
# Config[:debug] = true
# puts Config[:debug]
