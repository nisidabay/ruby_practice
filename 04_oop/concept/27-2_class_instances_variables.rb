#!/usr/bin/env ruby
# frozen_string_literal: true

# class_instances_variables.rb — class instance vars vs class vars
# Problem: @@var is shared across entire hierarchy (rarely what you want)
# Solution: @var on class object — each class gets its own counter

class Person
  class << self
    attr_reader :counter

    def counter_display
      # Handle pluralization properly
      word = name.downcase
      "#{@counter} #{word}#{'s' unless @counter == 1} created"
    end

    private

    def increment_counter
      @counter += 1
    end
  end

  @counter = 0

  def initialize(name)
    self.name = name
    self.class.__send__(:increment_counter) # Safer than `send`
  end

  def name=(name)
    # 1. Reject invalid updates by simply returning early
    return if name.nil? || name.empty?

    # 2. Assign valid names
    @name = name
  end

  def to_s
    "I am #{@name} from #{self.class}"
  end

  # Provide a safe way to read the name with a default fallback,
  # rather than baking the fallback into the setter.
  def name
    @name || 'Unknown'
  end
end

class Student < Person
  @counter = 0
end

a = Person.new('alice')
puts a
b = Person.new('bob')
puts b
b.name = 'Charles'
puts b
b.name = '' # Will be rejected by validation, keeps "Charles"
puts b
puts Person.counter_display

c = Student.new('Peter')
puts c
d = Student.new('') # Will be rejected by validation, becomes "Unknown" via the getter
puts d
puts Student.counter_display
