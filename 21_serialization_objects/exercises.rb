#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Serialization & Objects practice

require 'objspace'
require 'weakref'
require 'ostruct'
require 'delegate'
require 'observer'
require 'singleton'

puts '=== Exercise 1: Marshal ==='
data = { users: [{ name: 'Alice' }], time: Time.now }
bytes = Marshal.dump(data)
restored = Marshal.load(bytes)
puts "Match: #{restored == data}"

puts "\n=== Exercise 2: ObjectSpace ==="
counts = ObjectSpace.count_objects
puts "Live objects: #{counts[:TOTAL]}"

puts "\n=== Exercise 3: WeakRef ==="
obj = 'test'
weak = WeakRef.new(obj)
puts "Alive: #{weak.weakref_alive?}"

puts "\n=== Exercise 4: OpenStruct ==="
user = OpenStruct.new(name: 'Bob', age: 25)
puts "#{user.name}, #{user.age}"

puts "\n=== Exercise 5: DelegateClass ==="
class Shout < DelegateClass(String)
  def initialize(str); super(str); end
  def yell; "#{self.upcase}!"; end
end
puts Shout.new('hello').yell

puts "\n=== Exercise 6: Observable ==="
class Counter
  include Observable
  def increment
    changed
    notify_observers(self)
  end
end
class Listener
  def update(obj); puts "Changed! (count: #{obj})"; end
end
c = Counter.new
c.add_observer(Listener.new)
c.increment
