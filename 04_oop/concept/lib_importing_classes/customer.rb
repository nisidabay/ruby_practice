#!/usr/bin/env ruby
# frozen_string_literal: true

# customer.rb — imported class for require_relative demos

class Customer
  @@count = 0

  def initialize(id, name, addr)
    validate!(id, name, addr)
    @@count += 1
    @id = id
    @name = name
    @addr = addr
  end

  def display
    puts "Customer ##{@id}: #{@name} (#{@addr})"
  end

  def self.total
    @@count
  end

  private

  def validate!(id, name, addr)
    raise ArgumentError, 'ID must be a number' unless id.is_a?(Numeric)
    raise ArgumentError, 'Name required' if name.to_s.strip.empty?
    raise ArgumentError, 'Address required' if addr.to_s.strip.empty?
  end
end


# Thinking in Ruby
#
# This class is imported via require_relative — Ruby's canonical way to
# split code across files while keeping the namespace flat. The private
# validate! method checks arguments before they're stored, following the
# "fail fast" pattern: reject invalid data at the boundary, not after
# it's been stored.
