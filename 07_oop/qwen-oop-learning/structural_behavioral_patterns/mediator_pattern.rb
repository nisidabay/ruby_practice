#!/usr/bin/env ruby

# Mediator Pattern — Centralize Complex Communications
# Core Idea: Reduce chaotic dependencies between objects. Let them communicate
# indirectly through a mediator object that encapsulates the interaction.


# =============================================================================
# 1. THE MEDIATOR INTERFACE
# =============================================================================
# Defines how colleagues communicate.

class Mediator
  def notify(sender, event)
    raise NotImplementedError, "Subclasses must implement notify()"
  end
end


# =============================================================================
# 2. THE COLLEAGUES
# =============================================================================
# These are the objects that communicate through the mediator.

class Colleague
  def initialize(mediator)
    @mediator = mediator
  end

  protected

  attr_reader :mediator
end

class UserList < Colleague
  def initialize(mediator)
    super
    @users = ["Alice", "Bob", "Charlie"]
  end

  def display
    puts "Users: #{@users.join(", ")}"
  end

  def add_user(name)
    @users << name
    puts "[UserList] Added user: #{name}"
    mediator.notify(self, "user_added")
  end

  def remove_user(name)
    @users.delete(name)
    puts "[UserList] Removed user: #{name}"
    mediator.notify(self, "user_removed")
  end
end

class ChatLog < Colleague
  def initialize(mediator)
    super
    @log = []
  end

  def log_message(message)
    @log << "[#{Time.now.strftime("%H:%M")}] #{message}"
    puts "[ChatLog] Logged: #{message}"
  end

  def display
    puts "Chat Log:"
    @log.each { |entry| puts "  #{entry}" }
  end
end

class NotificationSystem < Colleague
  def initialize(mediator)
    super
    @notifications = []
  end

  def send_notification(message)
    @notifications << message
    puts "[Notification] Sent: #{message}"
  end

  def display
    puts "Notifications: #{@notifications.length} sent"
  end
end

class AdminPanel < Colleague
  def initialize(mediator)
    super
  end

  def update_stats(event)
    puts "[AdminPanel] Stats updated for event: #{event}"
  end
end


# =============================================================================
# 3. THE CONCRETE MEDIATOR
# =============================================================================
# Coordinates communication between colleagues.

class ChatMediator < Mediator
  def initialize
    @user_list = nil
    @chat_log = nil
    @notification = nil
    @admin = nil
  end

  def register_components(user_list, chat_log, notification, admin)
    @user_list = user_list
    @chat_log = chat_log
    @notification = notification
    @admin = admin
  end

  def notify(sender, event)
    case event
    when "user_added"
      @chat_log.log_message("User was added to the chat")
      @notification.send_notification("Welcome to the new user!")
      @admin.update_stats(event)
    when "user_removed"
      @chat_log.log_message("User left the chat")
      @notification.send_notification("A user has left")
      @admin.update_stats(event)
    when "message_sent"
      @chat_log.log_message(sender.class.name)
      @admin.update_stats(event)
    end
  end
end


# =============================================================================
# 4. COMPONENT WITH MEDIATOR COMMUNICATION
# =============================================================================

class ChatRoom
  def initialize(mediator)
    @mediator = mediator
  end

  def send_message(user, message)
    puts "[ChatRoom] #{user} says: #{message}"
    @mediator.notify(self, "message_sent")
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Mediator Pattern Demo ===\n\n"

# Create mediator
mediator = ChatMediator.new

# Create colleagues
user_list = UserList.new(mediator)
chat_log = ChatLog.new(mediator)
notification = NotificationSystem.new(mediator)
admin = AdminPanel.new(mediator)

# Register with mediator
mediator.register_components(user_list, chat_log, notification, admin)

# Create chat room that uses mediator
chat_room = ChatRoom.new(mediator)

puts "--- Initial State ---"
user_list.display
chat_log.display
notification.display

puts "\n--- Adding User (triggers multiple components) ---"
user_list.add_user("Diana")

puts "\n--- Chat Room Activity ---"
chat_room.send_message("Alice", "Hello everyone!")
chat_room.send_message("Bob", "Hi there!")

puts "\n--- Removing User (triggers multiple components) ---"
user_list.remove_user("Bob")

puts "\n--- Final State ---"
user_list.display
chat_log.display
notification.display
admin.display

puts "\n=== Key Takeaway ==="
puts "Without Mediator: Each component would need references to all others."
puts "With Mediator: Components only know about the mediator."
puts "This reduces coupling from N² to N dependencies."
