#!/usr/bin/env ruby
# frozen_string_literal: true

# change_constant_alternatives.rb — four ways to handle "changeable constants"

# 1. Class instance variable (RECOMMENDED)
class MessageV1
  @default_message = 'Hello, world'

  class << self
    attr_accessor :default_message

    def speak(message = nil)
      puts message || @default_message
    end
  end
end

MessageV1.speak('GOT')
MessageV1.default_message = 'Hello, hound'
MessageV1.speak

# 2. Class variable (@@)
class MessageV2
  @@default_message = 'Hello, world'

  def self.default_message=(msg)
    @@default_message = msg
  end

  def self.speak(message = nil)
    puts(message || @@default_message)
  end
end

MessageV2.speak('GOT')
MessageV2.default_message = 'Hello, hound'
MessageV2.speak

# 3. Config object (most flexible)
class MessageV3
  Config = Struct.new(:default_message)

  def self.config
    @config ||= Config.new('Hello, world')
  end

  def self.speak(message = nil)
    puts message || config.default_message
  end
end

MessageV3.speak('GOT')
MessageV3.config.default_message = 'Hello, hound'
MessageV3.speak

# 4. Immutable constant (true constant behavior)
class MessageV4
  DEFAULT_MESSAGE = 'Hello, world'

  def self.speak(message = nil)
    puts message || DEFAULT_MESSAGE
  end
end

MessageV4.speak('GOT')
MessageV4.speak


# Thinking in Ruby
#
# Ruby constants warn on reassignment but don't enforce immutability.
# This file shows four alternatives: class instance vars (recommended),
# class vars (@@), Struct-based config objects (most flexible), and true
# immutable constants. Each trades off between mutability control and
# ergonomics — Ruby trusts you to choose.
