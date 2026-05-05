#!/usr/bin/env ruby
# frozen_string_literal: true

require 'weakref'

# weak_ref.rb — allow GC to reclaim referenced objects

# Basic: create weak reference, object can be collected
weak = WeakRef.new('This may be collected')
puts weak.weakref_alive?  # => true
puts weak.__getobj__      # => "This may be collected"

# Weak cache pattern
class WeakCache
  def initialize
    @cache = {}
  end

  def get(key)
    @cache[key]&.__getobj__
  rescue WeakRef::RefError
    @cache.delete(key)
    nil
  end

  def set(key, value)
    @cache[key] = WeakRef.new(value)
    value
  end
end

cache = WeakCache.new
cache.set(:users, [{ name: 'Alice' }, { name: 'Bob' }])
p cache.get(:users)  # => [{name: "Alice"}, {name: "Bob"}]
# After GC, get(:users) may return nil — entries can be collected

# Observer pattern without memory leaks
class Subject
  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << WeakRef.new(observer)
  end

  def notify(event)
    @observers.reject! { |o| !o.weakref_alive? }
    @observers.each { |o| o.__getobj__.update(event) rescue next }
  end
end

class Observer
  def update(event)
    puts "Received: #{event}"
  end
end

s = Subject.new
s.add_observer(Observer.new)
s.notify('Hello')

