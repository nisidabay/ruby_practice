#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Blocks, procs, lambdas

# --- Block: pass a block to a method ---
def twice
  yield
  yield
end
twice { puts "Hello!" }

# --- Proc: store a block in a variable ---
multiply = Proc.new { |x, y| x * y }
puts multiply.call(6, 7)  # => 42
puts multiply[3, 4]       # => 12 (alternative syntax)

# --- Lambda: stricter about arguments ---
greet = ->(name) { "Hello, #{name}!" }
puts greet.call("Carlos")  # => Hello, Carlos!
# greet.call             # => ArgumentError (lambda enforces arity)
# greet.call("a", "b")   # => ArgumentError

# --- Lambda vs Proc: return behavior ---
def proc_return
  p = Proc.new { return "from proc" }  # returns from method
  p.call
  "after proc"  # never reached
end
puts proc_return  # => from proc

def lambda_return
  l = -> { return "from lambda" }  # returns from lambda only
  l.call
  "after lambda"  # reached!
end
puts lambda_return  # => after lambda

# --- map with a proc ---
to_upcase = Proc.new { |s| s.upcase }
puts ["ruby", "python", "go"].map(&to_upcase).inspect  # => ["RUBY", "PYTHON", "GO"]

# --- BONUS: Write a method that accepts a block and times it ---
