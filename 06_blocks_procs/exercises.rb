#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Blocks and procs practice

puts "=== Exercise 1: Custom each ==="
def my_each(arr)
  # --- your code here ---
  # HINT: arr.each { |item| yield item }
end

my_each([1,2,3]) { |n| puts n * 2 }

puts "
=== Exercise 2: Proc ==="
doubler = proc { |n| n * 2 }
# HINT: doubler.call(5) => 10
puts doubler.call(5)

puts "
=== Exercise 3: Lambda ==="
safe_divide = lambda { |a, b|
  # --- your code here ---
  # HINT: b == 0 ? nil : a / b
}
puts safe_divide.call(10, 2)
puts safe_divide.call(10, 0).inspect
