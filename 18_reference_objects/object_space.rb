#!/usr/bin/env ruby

# ObjectSpace - Traversing and Inspecting Live Objects
# ObjectSpace lets you access all living objects in Ruby's memory.

# ObjectSpace.each_object - Iterate over all objects of a type

strings = []
ObjectSpace.each_object(String) { |s| strings << s }
puts "Total String objects: #{strings.count}"

# Count all objects by type
counts = Hash.new(0)
ObjectSpace.each_object { |obj| counts[obj.class] += 1 }
puts counts.sort_by { |_, v| -v }.first(5).to_h

# ObjectSpace._id2ref - Convert object_id back to reference

str = 'hello'
id = str.object_id
retrieved = ObjectSpace._id2ref(id)
puts retrieved # => 'hello'
puts retrieved.equal?(str) # => true

# ObjectSpace.define_finalizer - Run cleanup when object is garbage collected
# Useful for resource management (files, connections, etc.)

class FileHandler
  def initialize(filename)
    @filename = filename
    ObjectSpace.define_finalizer(self, self.class.finalizer(@filename))
  end

  def self.finalizer(filename)
    proc { puts "Cleaning up: #{filename}" }
  end
end

FileHandler.new('test.txt')
nil # Remove reference
GC.start # Trigger garbage collection

# Caveat: Finalizers can be tricky - avoid referencing the object inside the proc

# Memory profiling use case
# Find the memory footprint of objects

class MemoryInspector
  def self.object_size(obj)
    ObjectSpace.memsize_of(obj)
  end

  def self.total_size(klass)
    total = 0
    ObjectSpace.each_object(klass) { |obj| total += ObjectSpace.memsize_of(obj) }
    total
  end
end

puts "String memory: #{MemoryInspector.total_size(String)} bytes"
