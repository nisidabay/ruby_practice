#!/usr/bin/env ruby
# frozen_string_literal: true

# object_space.rb — inspect all living objects in memory

# Count objects by type
counts = Hash.new(0)
ObjectSpace.each_object { |obj| counts[obj.class] += 1 }
p counts.sort_by { |k, v| -v }.first(5).to_h

# _id2ref: convert object_id back to reference
str = 'hello'
id = str.object_id
retrieved = ObjectSpace._id2ref(id)
p retrieved.equal?(str)  # => true

# Define finalizer (runs cleanup when object is GC'd)
class FileHandler
  def initialize(filename)
    @filename = filename
    ObjectSpace.define_finalizer(self, proc { puts "Cleaning up: #{filename}" })
  end
end

FileHandler.new('test.txt')
GC.start  # => "Cleaning up: test.txt"

# Memory inspection
p ObjectSpace.memsize_of('hello')        # memory of single object

