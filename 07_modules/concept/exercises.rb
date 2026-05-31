#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Modules: namespace, mixin, self methods, module_function

# --- Namespace: wrap constants and methods ---
module AppConfig
  VERSION = "2.1.0"
  def self.info
    "App v#{VERSION}"
  end
end
puts AppConfig::VERSION  # => 2.1.0
puts AppConfig.info      # => App v2.1.0

# --- Mixin with include (instance methods) ---
module Speakable
  def speak
    "Hello from #{self.class}"
  end
end

class Robot
  include Speakable
end
puts Robot.new.speak  # => Hello from Robot

# --- extend: adds module methods as class methods ---
module Logging
  def log(msg)
    puts "[LOG] #{msg}"
  end
end

class Server
  extend Logging
end
Server.log("Starting up...")  # => [LOG] Starting up...

# --- module_function: method callable on module AND private in classes ---
module MathHelpers
  def square(x)
    x * x
  end
  module_function :square
end
puts MathHelpers.square(9)    # => 81

# --- BONUS: Use include + extend together in one class ---
# class Worker
#   include Speakable        # -> instance.speak
#   extend Logging           # -> Worker.log(...)
# end
