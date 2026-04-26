#!/usr/bin/env ruby

# Mixins are a beautiful way to achieve something similar to multiple inheritance
# in Ruby. They allow us to include methods defined in a module into a class.
# These methods can be included as either instance or class methods. The example
# below demonstrates this design pattern:

module SampleModule
  module ClassMethods
    def method_static
      puts 'This is a static method'
    end
  end

  def instance_method
    puts 'This is an instance method'
  end
end

class SampleClass
  include SampleModule
  extend SampleModule::ClassMethods
end

# Usage examples
SampleClass.method_static        # Calls the class method from ClassMethods
SampleClass.new.instance_method  # Calls the instance method

### 💡 Pro-Tip: The Standard Ruby Idiom
# While the code above works perfectly, in idiomatic Ruby, you will rarely see
# `extend` called explicitly inside the class. Instead, Ruby developers usually
# use a hook method called `self.included` inside the module to automatically
# extend the class methods whenever the module is included. It looks like this:
# This makes the class definition much cleaner and encapsulates the mixin logic
# entirely inside the module.

module SampleModule
  # This block runs automatically when a class includes SampleModule
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def method_static
      puts 'This is a static method'
    end
  end

  def instance_method
    puts 'This is an instance method'
  end
end

class SampleClass
  include SampleModule # This single line now handles BOTH include and extend!
end
