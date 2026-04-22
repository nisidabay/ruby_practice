#!/usr/bin/env ruby

# WeakRef - Weak References for Memory-Safe Caching
# Weak references allow the garbage collector to collect objects even if referenced.

require 'weakref'

# Normal references prevent garbage collection
# Strong reference keeps object alive
# Object cannot be GC'd while strong_ref exists

# WeakRef allows GC to reclaim the object
# When memory pressure builds, GC can collect weakly-referenced objects

weak_ref = WeakRef.new('This may be collected')
puts weak_ref.__getobj__ # Access underlying object

# Weak reference cache pattern
# Cache entries can be GC'd when memory is needed, preventing bloat

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

  def exists?(key)
    get(key) != nil
  end
end

cache = WeakCache.new
cache.set(:users, [{ name: 'Alice' }, { name: 'Bob' }])
puts cache.exists?(:users) # => true
puts cache.get(:users)     # => [{:name=>"Alice"}, {:name=>"Bob"}]

# GC can reclaim the data when memory pressure increases
nil
GC.start
# cache.get(:users) might return nil after GC

# WeakRef status checking
# weakref_alive? checks if reference is still valid

original = 'test'
weak = WeakRef.new(original)
puts weak.weakref_alive? # => true

nil # Remove strong reference (string might be GC'd)
GC.start
puts weak.weakref_alive? # => false (object was collected)

# Use case: Observer pattern without memory leaks
# Observers don't prevent subjects from being collected

class Subject
  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << WeakRef.new(observer)
    cleanup_observers
  end

  def notify(event)
    @observers.each do |weak_obs|
      next unless weak_obs.weakref_alive?

      weak_obs.__getobj__.update(event)
    rescue WeakRef::RefError
      next
    end
  end

  private

  def cleanup_observers
    @observers.reject! { |o| !o.weakref_alive? }
  end
end

class Observer
  def update(event)
    puts "Received: #{event}"
  end
end

subject = Subject.new
observer = Observer.new
subject.add_observer(observer)
subject.notify('Hello') # => Received: Hello
