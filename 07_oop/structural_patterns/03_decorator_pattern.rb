#!/usr/bin/env ruby

# Problem: You want to add responsibilities to objects dynamically without subclassing.
# Example: A notification system where you can add SMS, Facebook, or logging to emails at runtime.
#
# Solution: Wrap objects with decorators that add behavior before/after delegating to the wrapped object.
# Visibility: Decorators wrap the original object, client sees the same interface.

class BasicNotifier
  def send(message)
    puts "Email: #{message}"
  end
end

class Decorator
  def initialize(notifier)
    @notifier = notifier
  end

  def send(message)
    @notifier.send(message)
  end
end

class SMSDecorator < Decorator
  def send(message)
    super
    puts "SMS: #{message}"
  end
end

class LogDecorator < Decorator
  def send(message)
    puts "Log: Starting to send message..."
    super
  end
end

# Usage: Wrap the base object with decorators to add behavior
notifier = BasicNotifier.new
puts "1. Just email:"
notifier.send("Hello!")

puts "\n2. Email + SMS:"
sms_notifier = SMSDecorator.new(BasicNotifier.new)
sms_notifier.send("Hello!")

puts "\n3. Log + Email + SMS:"
super_notifier = LogDecorator.new(SMSDecorator.new(BasicNotifier.new))
super_notifier.send("Hello!")

# Alternative: Composition with explicit method calls for simple extensions
# For simple extensions, use composition with explicit method calls:

class Notifier
  def send_email(msg)
    puts "Email: #{msg}"
  end

  def send_sms(msg)
    puts "SMS: #{msg}"
  end

  def send_facebook(msg)
    puts "Facebook: #{msg}"
  end

  def send_both(msg)
    send_email(msg)
    send_sms(msg)
  end

  def send_all(msg)
    send_email(msg)
    send_sms(msg)
    send_facebook(msg)
  end
end

puts "\n--- Composition-based Notification ---"

notifier = Notifier.new
puts "1. Email only:"
notifier.send_email("Hello!")

puts "\n2. Email + SMS:"
notifier.send_both("Hello!")

puts "\n3. All channels:"
notifier.send_all("Hello!")
