#!/usr/bin/env ruby
# frozen_string_literal: true

# lambdas.rb — strict argument checking, safe return behavior

# Creation: stabby syntax or lambda keyword
l1 = ->(x) { x * 2 }
l2 = lambda { |x| x * 2 }
p l1.call(5), l2.call(5)  # => 10 10

# Multi-line
greet = ->(name) do
  puts "Hello, #{name}!"
  puts "Welcome!"
end
greet.call("Alice")

# Argument STRICTNESS (unlike procs)
strict = ->(a, b) { a + b }
p strict.call(1, 2)  # => 3
# strict.call(1)     # => ArgumentError!
# strict.call(1,2,3) # => ArgumentError!

# return is SAFE — returns from lambda only, method continues
def test_lambda
  l = -> { return "From Lambda" }
  l.call
  "Method ended"  # reached
end
p test_lambda  # => "Method ended"

# Higher-order: function composition
def compose(f, g)
  ->(x) { f.call(g.call(x)) }
end
double = ->(x) { x * 2 }
increment = ->(x) { x + 1 }
p compose(increment, double).call(5)  # => 11 (5*2 + 1)

# Proc composition operators (Ruby 2.6+): << and >>
p (double << increment).call(5)  # 12 (increment first, then double)
p (double >> increment).call(5)  # 11 (double first, then increment)

# Check type
p proc {}.lambda?    # => false
p ->() {}.lambda?    # => true

