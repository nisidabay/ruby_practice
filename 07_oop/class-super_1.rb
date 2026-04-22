
# Implicit Arguments (The Default)
# When you call super without parentheses, Ruby automatically passes all
# arguments from the current method to the parent method.

class Bird
  def fly(speed, altitude)
    "Flying at #{speed} mph and #{altitude} feet."
  end
end

class Eagle < Bird
  def fly(speed, altitude)
    # Passes speed and altitude automatically
    super + " Also, I have keen eyesight."
  end
end

puts Eagle.new.fly(30, 1000)
# Output: Flying at 30 mph and 1000 feet. Also, I have keen eyesight.

# Calling with Specific ArgumentsIf you want to change the data before it
# reaches the parent, or if the parent expects different arguments, you use
# parentheses.

class Logger
  def log(message, level)
    "[#{level.upcase}] #{message}"
  end
end

class ErrorLogger < Logger
  def log(message)
    # We force the 'level' to be "error" for the parent
    super(message, "error")
  end
end

puts ErrorLogger.new.log("Database connection failed")
# Output: [ERROR] Database connection failed

# Calling with NO Arguments (super()). This is a common "gotcha." If your
# subclass method takes arguments, but the parent method takes none, you must
# use empty parentheses super(). If you just use super, Ruby will try to pass
# the arguments and trigger an ArgumentError.

class Parent
  def say_hello
    "Hello from the parent!"
  end
end

class Child < Parent
  def say_hello(name)
    # Using super() prevents passing 'name' to a method that doesn't want it
    super() + " Nice to meet you, #{name}."
  end
end

puts Child.new.say_hello("Alice")
# Output: Hello from the parent! Nice to meet you, Alice.

# Usage in initialize. This is perhaps the most frequent use case for super. It
# allows a subclass to set its own unique attributes while still letting the
# parent handle the shared setup.

class User
  attr_reader :username

  def initialize(username)
    @username = username
  end
end

class Admin < User
  attr_reader :permissions

  def initialize(username, permissions)
    # Let User handle the username
    super(username)
    # Admin handles the permissions
    @permissions = permissions
  end
end

admin = Admin.new("tech_guru", ["delete_user", "edit_post"])
puts "User: #{admin.username}, Perms: #{admin.permissions.join(', ')}"

# Working with Blocks. super also automatically passes any block given to the
# method to the parent.

class Calculator
  def calculate(a, b)
    result = a + b
    yield(result) if block_given?
  end
end

class Formatter < Calculator
  def calculate(a, b)
    super do |res|
      puts "The formatted result is: #{res}"
    end
  end
end

Formatter.new.calculate(5, 10)
# Output: The formatted result is: 15

