#!/usr/bin/env ruby
# frozen_string_literal: true

# class_variables_customer_count.rb — @@class_var shared across instances

class Customer
  @@total = 0

  def initialize(id, name, addr)
    @@total += 1
    @id = id
    @name = name
    @addr = addr
  end

  def display
    puts "Customer ##{@id}: #{@name} (#{@addr})"
  end

  def self.total
    @@total
  end
end

c1 = Customer.new(1, "Carlos", "Hortensia, Granada")
c2 = Customer.new(2, "Alicia", "Topete, Madrid")
c1.display
c2.display
puts "Total: #{Customer.total}"  # => 2

# Note: @@vars are shared across entire hierarchy (gotcha!)
# Prefer class instance variables (@total inside the class body) for most cases.


# Thinking in Ruby
#
# @@class_variables are shared across all instances AND the entire
# inheritance hierarchy — a subtle gotcha. For class-level state, Ruby
# prefers class instance variables (@counter declared at class scope),
# which give each subclass its own independent value. The @@ pattern is
# kept here for recognition, not recommendation.
