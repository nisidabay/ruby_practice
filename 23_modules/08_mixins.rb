#!/usr/bin/env ruby
# frozen_string_literal: true

# mixins.rb — share instance AND class methods from one module

# Non-idiomatic: explicit extend
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

SampleClass.method_static
SampleClass.new.instance_method

# Idiomatic Ruby: self.included hook auto-extends ClassMethods
module SampleModule
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

class SampleClass2
  include SampleModule  # single line handles both!
end

SampleClass2.method_static
SampleClass2.new.instance_method

