#!/usr/bin/env ruby
# frozen_string_literal: true

# 32_enumerable_deep_dive.rb — implement each → get 50+ methods free
#
# Enumerable is the MOST important mixin in Ruby.
# Implement ONE method (`each`) and you get map, select, reduce, sort,
# group_by, chunk, count, find, any?, all?, and 40+ more for FREE.
#
# WITHOUT Enumerable — write every iteration method yourself:
#
#   class Pipeline
#     def select(&b); result = []; each { |v| result << v if b.call(v) }; result; end
#     def map(&b);    result = []; each { |v| result << b.call(v) };   result; end
#     # 50 more methods to write...
#   end
#
# WITH Enumerable — implement each and include Enumerable:

class Pipeline
  include Enumerable

  def initialize(*stages)
    @stages = stages
  end

  def each(&block)
    @stages.each(&block)  # delegate to array's each
  end
end

pipe = Pipeline.new("build", "test", "deploy", "monitor")

# All these come free from including Enumerable + defining each:
puts "Select: #{pipe.select { |s| s.start_with?('d') }}"     # => ["deploy"]
puts "Map:    #{pipe.map(&:upcase)}"                          # => ["BUILD", "TEST", ...]
puts "Count:  #{pipe.count { |s| s.length > 4 }}"             # => 2
puts "Any?:   #{pipe.any? { |s| s == 'test' }}"              # => true
puts "Find:   #{pipe.find { |s| s.include?('p') }}"          # => "deploy"
puts "Group:  #{pipe.group_by { |s| s[0] }}"                 # => {"b"=>["build"], "t"=>["test"], ...}

# This is how Array, Hash, Range, Set all work.
# They define `each`, include Enumerable, and get the entire
# functional programming toolbox for free.

# Thinking in Ruby
#
# include Enumerable + implement each = get map, select, reduce, sort,
# group_by, chunk, tally, grep, and 40+ more methods free. This is the
# single most impactful Ruby pattern: it means EVERY collection in Ruby
# shares the same iteration API. Custom collections become as expressive
# as Array and Hash with just one method definition.
