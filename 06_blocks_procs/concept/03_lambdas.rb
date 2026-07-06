#!/usr/bin/env ruby
# frozen_string_literal: true

# 03_lambdas.rb — strict blocks: argument checking + safe returns

# Procs are lenient (missing args → nil) and return from the enclosing method.
# Lambdas are strict (wrong args → ArgumentError) and return from themselves.

# Strict argument checking:
double = ->(x) { x * 2 }
p double.call(5)   # => 10
# double.call        # => ArgumentError (wrong number of arguments)
# double.call(1, 2)  # => ArgumentError

# Safe return: lambda returns to its caller, method continues.
def safe
  l = -> { return "From lambda" }
  l.call
  "Method finished"  # this runs!
end
p safe  # => "Method finished"

# Use lambdas when you want predictability. Use procs when you
# don't care about argument counts and just want stored blocks.

# Thinking in Ruby
#
# The lambda syntax ->(x) { ... } is the most compact anonymous function
# syntax in any mainstream language. Combined with strict argument checking
# and safe return semantics, lambdas give you predictable, method-like
# behavior in an anonymous form. Ruby's distinction between procs and lambdas
# is unusual — most languages only have one kind of callable — but it gives
# you a spectrum from "casual block" (proc) to "strict function" (lambda).
