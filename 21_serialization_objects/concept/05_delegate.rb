#!/usr/bin/env ruby
# frozen_string_literal: true

# Problem: Delegate method calls to another object without writing boilerplate.
# Example: A Report class that wraps a File — you want report.write to call file.write.
#
# Solution: DelegateClass (stdlib) — creates a class that delegates to a wrapped object.
# Visibility: `require 'delegate'`. The generated class passes unknown methods to the delegate.

require 'delegate'

# Define a class that delegates to a String
class PrintableString < DelegateClass(String)
  def initialize(str)
    super(str)
  end

  def print
    puts "--- #{self} ---"  # self IS the string
  end
end

ps = PrintableString.new('Hello World')
puts ps.upcase       # => HELLO WORLD  (delegated to String)
puts ps.length       # => 11           (delegated)
ps.print             # => --- Hello World ---  (our method)

# Usage: Simple delegation with Forwardable (already in group 04)
require 'forwardable'

class Report
  extend Forwardable
  def_delegator :@file, :write, :save  # save → @file.write

  def initialize(filename)
    @file = File.open(filename, 'w')
  end
end

# This could also be done like this:
# Manual delegation (boilerplate for every method):
#
#   class PrintableString
#     def initialize(str); @str = str; end
#     def upcase; @str.upcase; end
#     def length; @str.length; end
#     # ... 100 more methods
#   end
#
# DelegateClass auto-delegates ALL methods. Forwardable is for selective delegation.
#
# Thinking in Ruby
#
# Ruby provides not one but two delegation mechanisms in stdlib — DelegateClass
# for full method forwarding and Forwardable for selective delegation. This
# abundance of choice reflects Ruby's philosophy: provide multiple patterns and
# let developers choose. DelegateClass is ideal for wrapper/decorator patterns
# where you want the wrapped object's entire interface, while Forwardable gives
# fine-grained control. Both avoid the boilerplate of manual forwarding.
