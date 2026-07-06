#!/usr/bin/env ruby
# frozen_string_literal: true

# 31_comparable.rb — implement <=> once, get <, >, <=, >=, between? free
#
# WITHOUT Comparable — write 6 comparison methods manually:
#
#   class Version
#     def <(other); major < other.major; end
#     def >(other); major > other.major; end
#     def <=(other); ...; end   # 6 methods, every class
#   end
#
# WITH Comparable — implement ONE method (<=>) and get all comparisons free:

class Version
  include Comparable

  attr_reader :major, :minor, :patch

  def initialize(major, minor, patch)
    @major = major; @minor = minor; @patch = patch
  end

  def <=>(other)
    [major, minor, patch] <=> [other.major, other.minor, other.patch]
  end

  def to_s = "v#{major}.#{minor}.#{patch}"
end

v1 = Version.new(2, 4, 1)
v2 = Version.new(3, 0, 0)
v3 = Version.new(2, 4, 1)

puts "#{v1} <  #{v2} → #{v1 < v2}"      # => true  (free from Comparable)
puts "#{v1} >  #{v2} → #{v1 > v2}"      # => false
puts "#{v1} == #{v3} → #{v1 == v3}"     # => true
puts "#{v1} >= #{v3} → #{v1 >= v3}"     # => true
puts "#{v1}.between?(#{v3}, #{v2}) = #{v1.between?(v3, v2)}"  # => true

# <=> returns -1, 0, or 1. Comparable builds EVERYTHING from that.
# Also gives: sort (via <=>), clamp, and the spaceship itself.
# All of Ruby's built-in comparable classes (String, Integer, Time) use this.

# Thinking in Ruby
#
# include Comparable + implement <=> = get 6 comparison methods free.
# The spaceship operator returns -1, 0, or 1, and Comparable derives <,
# >, <=, >=, ==, between?, clamp from it. This is Ruby's most elegant
# mixin: one method unlocks a complete comparison interface.
