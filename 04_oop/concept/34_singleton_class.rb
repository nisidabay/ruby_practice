#!/usr/bin/env ruby
# frozen_string_literal: true

# 34_singleton_class.rb — eigenclass: methods on ONE object, not the whole class
#
# Every Ruby object has its own hidden class — the singleton class (eigenclass).
# Methods defined there exist on THAT object only.
#
# WITHOUT singleton methods — you'd create a whole subclass for one special case:
#
#   class LoggingArray < Array; def log; puts "logging..."; end; end
#   arr = LoggingArray.new  # whole class for one method
#
# WITH singleton methods — attach behavior to ONE object:

# 1. def object.method — singleton method on an instance
greeter = +"hello"  # + unfreezes the string (frozen_string_literal is on)
def greeter.shout
  upcase + "!"
end
puts greeter.shout  # => "HELLO!"
# "world".shout      # => NoMethodError — only greeter has it

# 2. class << self — singleton methods on a class (= class methods!)
class Server
  class << self
    def running?; true; end
    def version; "3.2.1"; end
  end
end
puts Server.running?  # => true (this IS a singleton method — on the Server object)
puts Server.version   # => "3.2.1"

# The revelation: "class methods" in Ruby ARE singleton methods.
# class << self opens the singleton class of `self` (which IS the Class object).
# def self.method is just syntactic sugar for the same thing.

# 3. Open the singleton class explicitly
obj = Object.new
class << obj
  attr_accessor :metadata
end
obj.metadata = {created_at: Time.now}
puts "Metadata: #{obj.metadata[:created_at]}"  # only THIS obj has metadata

# Singleton methods and class methods are the same mechanism.
# The difference is just WHOSE singleton class you're opening.

# Thinking in Ruby
#
# Every Ruby object has a hidden singleton class (eigenclass). Methods
# defined there exist on THAT object only. The revelation: "class methods"
# (def self.method) ARE singleton methods on the Class object. class <<
# self opens this class. Understanding the singleton class is the key to
# Ruby's entire object model.
