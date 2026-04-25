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

# Alternative: Module-based singleton for configuration
# For configuration, use a module with module-level variables:

module Config
  @settings = {}

  def self.[](key)
    @settings[key]
  end

  def self.[]=(key, value)
    @settings[key] = value
  end

  def self.all
    @settings.dup
  end
end

puts "\n--- Module-based Singleton ---"

Config[:debug] = true
Config[:log_level] = "verbose"
Config[:max_connections] = 100

puts "Debug mode: #{Config[:debug]}"
puts "Log level: #{Config[:log_level]}"
puts "Max connections: #{Config[:max_connections]}"
puts "\nAll settings: #{Config.all.inspect}"
