#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: You want a child class to inherit and specialize behavior from a
# parent class. Example: A Dog is an Animal - it should speak like an
# **animal**
# but with dog-specific details.
#
# Solution: Use inheritance with the < symbol to derive from a parent class.
# Visibility: Child has access to parent's public/protected methods (and
# inherits private methods, though they cannot be called with an explicit
# receiver). Child can override them.

### When to Use

# - Clear hierarchical relationship exists
# - Child needs ALL parent behavior
# - Polymorphism is required
# - Liskov Substitution Principle holds (child can replace parent anywhere)

### Code Example
class Animal
  attr_reader :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def speak
    raise NotImplementedError, 'Subclasses must implement #speak'
  end

  def eat(food)
    "#{name} is eating #{food}"
  end
end

class Dog < Animal
  attr_reader :breed

  def initialize(name, age, breed)
    super(name, age)  # Delegate shared setup to parent
    @breed = breed    # Child handles its own unique attribute
  end

  def speak
    "#{name} says: Woof!"
  end

  def eat(food)
    super + ' with enthusiasm!' # Extend parent method with super
  end

  def fetch(item)
    "#{name} is fetching the #{item}"
  end
end

class Cat < Animal
  def speak
    "#{name} says: Meow!"
  end
end

# Usage
buddy = Dog.new('Buddy', 3, 'Golden Retriever')
buddy.speak           # => "Buddy says: Woof!"
buddy.eat('kibble')   # => "Buddy is eating kibble with enthusiasm!"
buddy.breed           # => "Golden Retriever"

whiskers = Cat.new('Whiskers', 5)
whiskers.speak        # => "Whiskers says: Meow!"
whiskers.eat('fish')  # => "Whiskers is eating fish" (inherited, not extended)

# Thinking in Ruby
#
# Ruby inheritance uses < to derive from a parent class. The super keyword
# calls the parent's version of the same method — optional, explicit, no
# auto-call. child calls it when it wants to extend behavior. The
# NotImplementedError pattern for abstract methods enforces the contract
# at runtime rather than compile time.
