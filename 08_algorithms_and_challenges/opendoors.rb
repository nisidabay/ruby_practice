#!/usr/bin/env ruby
# frozen_string_literal: true
# Opendoors
# This file contains Ruby code for opendoors.


doors = Array.new(101, 0)
print 'Open doors '
(1..100).step do |i|
  (i..100).step(i) do |d|
    doors[d] = doors[d] ^= 1
    print "#{i} " if (i == d) && (doors[d] == 1)
  end
end
