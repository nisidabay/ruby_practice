#!/usr/bin/env ruby
# frozen_string_literal: true

# decorator_pattern.rb — wrap objects to add behavior dynamically

class BasicNotifier
  def send(message)
    puts "Email: #{message}"
  end
end

class SMSDecorator
  def initialize(notifier)
    @notifier = notifier
  end

  def send(message)
    @notifier.send(message)
    puts "SMS: #{message}"
  end
end

class LogDecorator
  def initialize(notifier)
    @notifier = notifier
  end

  def send(message)
    puts "Log: sending..."
    @notifier.send(message)
  end
end

# Just email
BasicNotifier.new.send("Hello!")

# Email + SMS
SMSDecorator.new(BasicNotifier.new).send("Hello!")

# Log + Email + SMS
LogDecorator.new(SMSDecorator.new(BasicNotifier.new)).send("Hello!")

