#!/usr/bin/env ruby
# frozen_string_literal: true

# exercises.rb — Recursive functions

# --- Count down from n to 0 ---
def countdown(n)
  return if n < 0
  puts n
  countdown(n - 1)
end
countdown(5)

# --- Sum of digits: sum_digits(123) => 6 ---
def sum_digits(n)
  # your code here
  # hint: return n if n < 10; n % 10 + sum_digits(n / 10)
end
puts sum_digits(123)  # => 6

# --- Reverse a string recursively ---
def reverse(str)
  # your code here — hint: str[-1] + reverse(str[0..-2])
end
puts reverse("Carlos")  # => solraC
