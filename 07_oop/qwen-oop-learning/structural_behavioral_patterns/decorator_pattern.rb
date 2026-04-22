#!/usr/bin/env ruby

# Decorator Pattern — Add Responsibilities Dynamically
# Core Idea: Attach new behaviors or responsibilities to an object without
# subclassing—and without altering its original class.


# =============================================================================
# 1. THE BASE OBJECT
# =============================================================================
# This is the simple, original object that does the core work.

class BasicNotifier
  def send(message)
    puts "Email: #{message}"
  end
end


# =============================================================================
# 2. THE BASE DECORATOR
# =============================================================================
# This acts as a wrapper. It takes a notifier and passes the work to it.

class Decorator
  def initialize(notifier)
    @notifier = notifier
  end

  def send(message)
    @notifier.send(message)
  end
end


# =============================================================================
# 3. ADDING BEHAVIORS (Concrete Decorators)
# =============================================================================
# We inherit from the wrapper and add our new steps.

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

class FacebookDecorator < Decorator
  def send(message)
    super
    puts "Facebook: #{message}"
  end
end


# =============================================================================
# 4. REAL-WORLD EXAMPLE: Coffee Add-ons
# =============================================================================

class Coffee
  def cost
    2.0
  end

  def description
    "Coffee"
  end
end

class Milk < Coffee
  def initialize(coffee)
    @coffee = coffee
  end

  def cost
    @coffee.cost + 0.5
  end

  def description
    "#{@coffee.description}, Milk"
  end
end

class Sugar < Coffee
  def initialize(coffee)
    @coffee = coffee
  end

  def cost
    @coffee.cost + 0.2
  end

  def description
    "#{@coffee.description}, Sugar"
  end
end

class Whip < Coffee
  def initialize(coffee)
    @coffee = coffee
  end

  def cost
    @coffee.cost + 0.7
  end

  def description
    "#{@coffee.description}, Whip"
  end
end


# =============================================================================
# 5. REAL-WORLD EXAMPLE: Data Stream Decorators
# =============================================================================

class DataSource
  def write_data(data); end
  def read_data; end
end

class FileDataSource < DataSource
  def initialize(filename)
    @filename = filename
  end

  def write_data(data)
    puts "  [File] Writing #{data.length} bytes to #{@filename}"
  end

  def read_data
    puts "  [File] Reading from #{@filename}"
    "Sample data"
  end
end

class DataSourceDecorator < DataSource
  def initialize(source)
    @source = source
  end

  def write_data(data)
    @source.write_data(data)
  end

  def read_data
    @source.read_data
  end
end

class EncryptionDecorator < DataSourceDecorator
  def write_data(data)
    encrypted = "ENCRYPTED:#{data}"
    puts "  [Encryption] Encrypting data"
    super(encrypted)
  end

  def read_data
    data = super
    puts "  [Encryption] Decrypting data"
    data.sub("ENCRYPTED:", "")
  end
end

class CompressionDecorator < DataSourceDecorator
  def write_data(data)
    compressed = "COMPRESSED:#{data}"
    puts "  [Compression] Compressing data"
    super(compressed)
  end

  def read_data
    data = super
    puts "  [Compression] Decompressing data"
    data.sub("COMPRESSED:", "")
  end
end


# =============================================================================
# HOW TO USE IT
# =============================================================================

puts "=== Decorator Pattern Demo ===\n\n"

# Notifier example
puts "--- Notification Decorators ---"
puts "\n1. Just the basic email:"
notifier = BasicNotifier.new
notifier.send("Hello!")

puts "\n2. Email + SMS:"
sms_notifier = SMSDecorator.new(BasicNotifier.new)
sms_notifier.send("Hello!")

puts "\n3. Log + Email + SMS:"
super_notifier = LogDecorator.new(SMSDecorator.new(BasicNotifier.new))
super_notifier.send("Hello!")

puts "\n4. All decorators stacked:"
mega_notifier = FacebookDecorator.new(
  LogDecorator.new(
    SMSDecorator.new(BasicNotifier.new)
  )
)
mega_notifier.send("Hello!")

# Coffee example
puts "\n--- Coffee Shop Order ---"
coffee = Coffee.new
puts "Order: #{coffee.description}"
puts "Cost: $#{coffee.cost}"

coffee_with_milk = Milk.new(coffee)
puts "\nOrder: #{coffee_with_milk.description}"
puts "Cost: $#{coffee_with_milk.cost}"

coffee_with_everything = Whip.new(
  Sugar.new(
    Milk.new(Coffee.new)
  )
)
puts "\nOrder: #{coffee_with_everything.description}"
puts "Cost: $#{coffee_with_everything.cost}"

# Data stream example
puts "\n--- Data Stream Decorators ---"
source = FileDataSource.new("data.txt")

puts "\nWriting plain data:"
source.write_data("Secret message")

puts "\nWriting encrypted data:"
encrypted_source = EncryptionDecorator.new(source)
encrypted_source.write_data("Secret message")

puts "\nWriting compressed and encrypted data:"
compressed_encrypted = EncryptionDecorator.new(
  CompressionDecorator.new(source)
)
compressed_encrypted.write_data("Secret message")

puts "\n=== Key Takeaway ==="
puts "Decorator adds responsibilities dynamically without subclassing."
puts "Unlike inheritance, you can mix and match decorators at runtime."
puts "Common uses: I/O streams, middleware, UI components, notifications."
puts "Difference from Strategy: Decorator adds behavior, Strategy swaps it."
