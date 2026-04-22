#!/usr/bin/env ruby

# In Ruby, `yield` allows a method to invoke a block of code passed to it. It
# effectively pauses the method's execution, runs the block, and then returns
# control to the method.

# Here are the primary patterns for using `yield`, ranging from basic usage to
# more advanced idioms.

## 1. Basic Execution
# The simplest use case is executing a block within a method sequence. This is
# often used for "sandwich" code patterns (setup/teardown).

def wrapper
  puts 'Start of method'
  yield
  puts 'End of method'
end

wrapper { puts '>>> Inside the block <<<' }

# Output:
# Start of method
# >>> Inside the block <<<
# End of method

## 2. Passing Arguments to the Block
# You can pass arguments from the method to the block using `yield`. This is
# how iterators (like `.each` or `.map`) are built.

def repeat_three_times(&)
  1.upto(3, &)
end

# The block accepts the argument inside pipes |n|
repeat_three_times { |n| puts "Iteration #{n}" }

# Output:
# Iteration 1
# Iteration 2
# Iteration 3

## 3. Capturing the Block's Return Value
# `yield` returns the result of the block's last evaluated expression. This
# allows you to inject logic into calculations.

def transform_number(num)
  # Yield the number, capture the result
  result = yield(num)
  puts "Original: #{num}, Transformed: #{result}"
end

transform_number(10) { |n| n * n } # Squaring
transform_number(10) { |n| n + 5 } # Adding

# Output:
# Original: 10, Transformed: 100
# Original: 10, Transformed: 15

## 4. Conditional Yielding (`block_given?`)
# If you try to `yield` when no block was passed, Ruby raises a
# `LocalJumpError`. Use `block_given?` to make the block optional.

def maybe_yield
  puts 'Method started'
  puts 'No block detected' unless block_given?
  yield
  puts 'Method ended'
end

maybe_yield { puts 'Block executed!' }
maybe_yield # This won't crash

## 5. Idiomatic "Sandwich" Pattern (Resource Management)
# This is a common real-world pattern for file handling, database transactions,
# or timing code. It ensures cleanup code always runs, even if the block raises
# an error.

def with_timing
  start_time = Time.now
  puts 'Starting operation...'

  begin
    yield
  ensure
    # This code runs regardless of errors
    end_time = Time.now
    duration = end_time - start_time
    puts "Operation finished in #{duration.round(2)} seconds."
  end
end

with_timing do
  sleep(1)
  puts 'Processing heavy data...'
end

## Expert Note: `yield` vs. `&block`

# While `yield` is faster and idiomatic for simple execution, you can also
# capture a block explicitly using the `&` prefix (e.g., `def method(&block)`).

# Use `yield` when:
# *   You just need to invoke the block.
# *   You want the best performance (it avoids creating a Proc object).

# Use `&block` when:
# *   You need to pass the block to another method.
# *   You need to introspect the block (check its arity, etc.).

## **Example of passing a block forward:**
def internal_method(&block)
  block.call
end

def external_method(&)
  # We must use &block here because we need to pass it to another method
  internal_method(&)
end

def with_timer(label)
  start_time = Time.now
  # We yield to the block, capturing its return value
  result = yield
  end_time = Time.now

  duration = end_time - start_time
  puts "#{label} took #{duration} seconds"

  # Crucially, we return the result so the user's code isn't broken
  result
end

# Usage
# The block returns the array, 'result' captures it, and the method returns it.
data = with_timer('Array generation') do
  # sleep(1)
  (1..100).to_a
end

# puts data.first # Output: 1
p data
